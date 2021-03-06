package com.restaurantify

import groovy.transform.CompileStatic

/**
 * Clase controlador para las Valoraciones, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class ValoracionController {
    ValoracionService valoracionService
    PlatoService platoService

    /**
     *  Crea una valoracón con los parametros
     */
    def crear(ValoracionCommand vc) {
        // Si no tiene idPlato redirigimos al index
        if(vc.idPlato == null) {
           redirect(uri: "/")
            return
        }

        // Comprobamos si hay errores
        if(vc.hasErrors()) {
            flash.error = true
            flash.valoracionMessage = "default.valoracion.errorCrear.message"
            Plato plato = platoService.findById(vc.idPlato)
            render(view: "/plato/plato", model: [
                    valoracion: vc,
                    plato: plato,
                    valoraciones: valoracionService.listar(plato)
            ])
            return
        }

        // Creamos la valoración
        valoracionService.crear(vc)

        // Imprimimos el mensaje
        flash.valoracionMessage = "default.valoracion.creado.message"
        redirect(controller: "plato", action: "show", params: [id: vc.idPlato])
    }

    /**
     *  Actualiza una valoracón con los parametros
     */
    def actualizar(ValoracionCommand vc) {
        // Si no tiene idPlato o idValoracion redirigimos al index
        if(vc.idPlato == null || vc.idValoracion == null) {
            redirect(uri: "/")
            return
        }

        // Comprobamos si hay errores
        if(vc.hasErrors()) {
            flash.error = true
            flash.valoracionMessage = "default.valoracion.errorCrear.message"
            Plato plato = platoService.findById(vc.idPlato)
            render(view: "/plato/plato", model: [
                    valoracion: vc,
                    plato: plato,
                    valoraciones: valoracionService.listar(plato)
            ])
            return
        }

        // Creamos la valoración
        valoracionService.actualizar(vc)

        // Imprimimos el mensaje
        flash.valoracionMessage = "default.valoracion.actualizada.message"
        redirect(controller: "plato", action: "show", params: [id: vc.idPlato])
    }

    /**
     * Elimina una valoración dado el id de la valoración.
     */
    def eliminar(Long idValoracion, Long idPlato) {
        // Si no tiene idValoracion redirigimos al index
        if(idValoracion == null) {
            redirect(uri: "/")
            return
        }

        // Borramos la valoración
        valoracionService.eliminar(idValoracion)

        // Imprimimos el mensaje
        flash.valoracionMessage = "default.valoracion.eliminada.message"
        redirect(controller: "plato", action: "show", params: [id: idPlato])
    }

    /**
     * Elimina una valoración dado el id de la valoración.
     */
    def eliminarAdmin(Long id) {
        // Si no tiene idValoracion redirigimos al index
        if(id == null) {
            redirect(uri: "/")
            return
        }

        Plato p = platoService.findByValoracion(id)

        // Borramos la valoración
        valoracionService.eliminar(id)

        // Imprimimos el mensaje
        flash.valoracionCliente = "default.valoracion.cliente.eliminada.message"
        redirect(controller: "plato", action: "show", params: [id: p.id])
    }
}

class ValoracionCommand {
    Long idValoracion
    Integer puntuacion
    String comentario
    Long idPlato

    static constraints = {
        idValoracion nullable: true
        puntuacion range: 1..10, blank: false
        comentario maxSize: 1000
    }
}
