package com.restaurantify

import com.restaurantify.DefaultService
import com.restaurantify.Plato
import com.restaurantify.Valoracion
import grails.gorm.transactions.Transactional
import grails.validation.ValidationException

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Plato.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class ValoracionService extends DefaultService {
    PlatoService platoService
    ClienteService clienteService


    /**
     * Inserta la valoración en la base de datos.
     * @param vc
     */
    @Transactional
    void crear(ValoracionCommand vc) {
        // Obtenemos los valores
        Plato p = platoService.findById(vc.idPlato)
        Cliente c = clienteService.clienteSession()

        // Creamos una nueva valoracion
        Valoracion v = new Valoracion(puntuacion: vc.puntuacion, comentario: vc.comentario, plato: p, cliente: c )

        // Guarda la valoracion
        v.save()
    }

    /**
     * Obtiene una valoración dado un cliente y un plato.
     * @param c
     * @param p
     * @return
     */
    Valoracion findByClienteAndPlato(Cliente c, Plato p) {
        return Valoracion.findByClienteAndPlato(c, p)
    }

    /**
     * Actualiza la valoracion en la base de datos.
     * @param vc
     */
    @Transactional
    void actualizar(ValoracionCommand vc) {
        // Actualiza la valoración
        Valoracion v = Valoracion.findById(vc.idValoracion)
        v.with {
            comentario = vc.comentario
            puntuacion = vc.puntuacion
        }
    }

    /**
     * Elimina la valoración en la base de datos.
     * @param v
     */
    @Transactional
    void eliminar(Long id) {
        // Elimina la valoracion
        Valoracion.executeUpdate("delete Valoracion where id = :id", [id: id] )
    }

    /**
     * Lista todos las valoraciones dato el id del plato.
     * @param p de plato
     * @return lista de valoraciones
     */
    def listar (Plato p) {
        List<Valoracion> lista = Valoracion.findAllByPlato(p, params)

        Integer total = Valoracion.countByPlato(p) ?: 0

        Integer puntuacionTotal = Valoracion.executeQuery(
                "SELECT SUM(puntuacion) FROM Valoracion WHERE plato_id = :pId", [pId: p.id])[0] ?: 0

        Float puntuacionFinal = (total != 0 && puntuacionTotal != 0) ? (puntuacionTotal / total) : 0

        return [lista: lista, total: total, pf: puntuacionFinal]
    }
}
