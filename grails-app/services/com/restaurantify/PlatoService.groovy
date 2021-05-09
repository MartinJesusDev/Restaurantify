package com.restaurantify

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile

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
    void crearPlato(Plato p) {
        // Comprueba la foto del plato
        uploadFilePlato(p)

        // Guarda el plato
        p.save()
    }

    /**
     * Actualiza el plato.
     * @param p
     */
    @Transactional
    void actualizarPlato(Plato p) {
        // Comprueba si se actualizo el plato
        uploadFilePlato(p)

        // Guarda el plato
        p.save()
    }

    /**
     * Elimina el plato pasado por parametro.
     * @param p
     */
    @Transactional
    void eliminarPlato(Plato p){
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

    List<Plato> listadoFiltrado(FiltroPlatos filtro){
        // Consulta sin alergenos
         List<Plato> platos = Plato.findAllByCategoriaInListAndTotalBetween(
                filtro.categorias, filtro.precioMin, filtro.precioMax)

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
                    println "###Plato con alergenos --> $p.nombre"
                    platosConAlergenos.add(p)
                }
            }

            // Eliminamos los platos con alergenos de los platos
            platos.removeAll(platosConAlergenos)
        }
        // retornamos los platos
        return  platos
    }

}
