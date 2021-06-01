package com.restaurantify

import grails.gorm.DetachedCriteria
import grails.gorm.transactions.Transactional
import org.hibernate.criterion.CriteriaSpecification
import org.springframework.web.multipart.MultipartFile

import javax.swing.border.Border

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Plato.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class PlatoService extends DefaultService {

    /**
     * Inserta el plato en la base de datos.
     * @param p
     */
    @Transactional
    void crear(Plato p) {
        // Comprueba la foto del plato
        uploadFilePlato(p)

        // Calcula el total del plato
        p.total = calcularTotal(p)

        // Guarda el plato
        p.save()
    }

    /**
     * Actualiza el plato.
     * @param p
     */
    @Transactional
    void actualizar(Plato p) {
        // Comprueba si se actualizo el plato
        uploadFilePlato(p)

        // Calcula el total del plato
        p.total = calcularTotal(p)

        // Si no esta disponible retiramos el plato de todas las cestas
        if(!p.disponible) {
            Cesta.where {
                plato {
                    eq 'id', p.id
                }
            }.deleteAll()
        }

        // Guarda el plato
        p.save()
    }

    /**
     * Elimina el plato pasado por parametro.
     * @param p
     */
    @Transactional
    void eliminar(Plato p){
        // Elimina el plato
        p.delete()
    }

    /**
     * Controla la subida de una imagén del plato.
     */
    void uploadFilePlato(Plato plato) {
        try {
            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPlato')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/platos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                plato.imagen = f.originalFilename
            }
        } catch(Exception e) {}
    }

    /**
     * Retorna una lista con todos los platos.
     * @return Plato
     */
    List<Plato> listar () {
        return Plato.findAll()
    }

    /**
     * Realiza un listado de platos dado el filtro pasado por parametro.
     * @param filtro parametros de filtro
     * @return
     */
    List<Plato> listadoFiltrado(FiltroPlatos filtro){
        // Consulta sin alergenos
         List<Plato> platos = Plato.findAllByCategoriaInListAndTotalBetweenAndDisponible(
                filtro.categorias, filtro.precioMin, filtro.precioMax, true)

        // Eliminamos los platos que contengan alergenos
        if(filtro.alergenos) {
            List<Plato> platosConAlergenos = []

            // Recorremos los platos
            platos.each { Plato p ->
                Boolean contieneAlergeno = false
                p.alergenos.each {Alergeno a  ->
                    // Intentamos encontrar el alergeno
                    Boolean encontrado = filtro.alergenos.contains(a)

                    // Si encontro uno salimos
                    if(encontrado){
                        contieneAlergeno = true
                        return
                    }
                }
                if(contieneAlergeno){
                    platosConAlergenos.add(p)
                }
            }

            // Eliminamos los platos con alergenos de los platos
            platos.removeAll(platosConAlergenos)
        }
        // retornamos los platos
        return  platos
    }

    /**
     * Calcula el total del plato.
     * @param p
     * @return float
     */
    Float calcularTotal(Plato p) {
        return ((p.precio * ( 1 - (p.descuento / 100 ))) * (1 + (p.iva / 100))).round(2)
    }

    /**
     * Obtiene un plato dado el id, si esta disponible.
     * @param id
     * @return
     */
    Plato findById(Long id){
        return Plato.findByIdAndDisponible(id, true)
    }

    /**
     * Lista los 5 platos más pedidos.
     * @return
     */
    List<Plato> platosMasPedidos() {
        DetachedCriteria<Plato> query = Plato.where {
            id in DetallesPedido.executeQuery("select dp.plato.id from DetallesPedido dp GROUP BY dp.plato.id ORDER BY SUM(unidades) DESC", [max: 5])
        }

        return query.list()
    }
}
