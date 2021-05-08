package com.restaurantify

import grails.validation.ValidationException
import groovy.transform.CompileStatic

/**
 * Clase controlador para los Platos, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class PlatoController {
    PlatoService platoService
    CategoriaService categoriaService
    AlergenoService alergenoService

    /**
     * Controla la creación del plato.
     */
    def crear(Plato plato) {
        // Comprobamos si hay errores
        if(plato.hasErrors()) {
            render(view: "/admin/platos",
                    model: [
                        listadoPlatos: platoService.listar(),
                        listadoAlergenos: alergenoService.listar(),
                        listadoCategorias: categoriaService.listar(),
                        plato: plato
                    ])
            return
        }

        // Intentamos crear el plato
        platoService.crearPlato(plato)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.plato.creado.message"
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la eliminación del plato.
     */
    def eliminar(Plato plato){
        if(!plato.id) {
            render(view: "/admin/platos",
                    model: [
                            listadoPlatos: platoService.listar(),
                            listadoAlergenos: alergenoService.listar(),
                            listadoCategorias: categoriaService.listar(),
                    ])
            return
        }

        platoService.eliminarPlato(plato)

        flash.message = "default.plato.eliminado.message"
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la actualización del plato.
     */
    def actualizar (Plato plato) {
        // Comprobamos si hay errores
        if(plato.hasErrors()) {
            render(view: "/admin/platos",
                    model: [
                            listadoPlatos: platoService.listar(),
                            listadoAlergenos: alergenoService.listar(),
                            listadoCategorias: categoriaService.listar(),
                            plato: plato
                    ])
            return
        }

        // Intentamos crear el plato
        platoService.actualizarPlato(plato)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.plato.actualizado.message"
        redirect(controller: "admin", action: "platos")
    }
}
