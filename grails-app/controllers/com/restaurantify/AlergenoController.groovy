package com.restaurantify


import groovy.transform.CompileStatic

/**
 * Clase controlador para los Aleregnos, que contrala las peticiones y errores.
 * Utiliza el servicio alergeno para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class AlergenoController {
    AlergenoService alergenoService

    /**
     * Controla la creación del alergeno.
     */
    def crear(Alergeno alergeno) {
        // Comprobamos si hay errores
        if(alergeno.hasErrors()) {
            render(view: "/admin/alergenos",
                    model: [
                            alergeno: alergeno,
                            listadoAlergenos: alergenoService.listar()
                    ])
            return
        }

        // Intentamos crear el alergeno
        alergenoService.crear(alergeno)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.alergeno.creado.message"
        redirect(controller: "admin", action: "alergenos")
    }

    /**
     * Controla la eliminación del alergeno.
     */
    def eliminar(Alergeno alergeno){
        if(!alergeno.id) {
            render(view: "/admin/alergenos",
                    model: [listadoAlergenos: alergenoService.listar()])
            return
        }

        // Elimina el alergeno
        alergenoService.eliminar(alergeno)

        // Redirige e imprime el mensaje de eliminación
        flash.message = "default.alergeno.eliminado.message"
        redirect(controller: "admin", action: "alergenos")
    }

    /**
     * Controla la actualización del alergeno.
     */
    def actualizar (Alergeno alergeno) {
        // Comprobamos si hay errores
        if(alergeno.hasErrors()) {
            render(view: "/admin/alergenos",
                    model: [
                            alergeno: alergeno,
                            listadoAlergenos: alergenoService.listar()
                    ])
            return
        }

        // Intentamos crear el alergeno
        alergenoService.actualizar(alergeno)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.alergeno.actualizado.message"
        redirect(controller: "admin", action: "alergenos")
    }
}
