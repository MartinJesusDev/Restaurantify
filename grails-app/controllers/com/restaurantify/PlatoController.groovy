package com.restaurantify

import grails.validation.ValidationException
import org.springframework.web.multipart.MultipartFile

class PlatoController {
    PlatoService platoService
    CategoriaService categoriaService

    /**
     * Controla la creación del plato.
     */
    def crear(Plato plato) {
        println plato
        try {
            // Comprobamos si hay errores
            if(plato.hasErrors()) {
                render(view: "../plato/platos", model: [
                        listadoPlatos: Plato.findAll(),
                        listadoAlergenos: Alergeno.findAll(),
                        listadoCategorias: categoriaService.listarCategorias(),
                        plato: plato])
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPlato')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/platos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                plato.imagen = f.originalFilename
            }

            // Intentamos crear el plato
            platoService.crearPlato(plato)


        } catch (ValidationException e) {
            render(view: "../plato/platos", model: [
                    listadoPlatos: Plato.findAll(),
                    listadoAlergenos: Alergeno.findAll(),
                    listadoCategorias: categoriaService.listarCategorias(),
                    plato: plato])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.plato.creado.message")
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la eliminación del plato.
     */
    def eliminar(Plato plato){
        if(!plato.id) {
            render(view: "platos", model: [
                    listadoPlatos: Plato.findAll(),
                    listadoAlergenos: Alergeno.findAll(),
                    listadoCategorias: categoriaService.listarCategorias()]
            )
            return
        }

        platoService.eliminarPlato(plato)

        flash.message = message(code: "default.plato.eliminado.message")
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la actualización del plato.
     */
    def actualizar (Plato plato) {
        try {
            // Comprobamos si hay errores
            if(plato.hasErrors()) {
                render(view: "platos", model: [
                        plato : plato,
                        listadoPlatos: Plato.findAll(),
                        listadoAlergenos: Alergeno.findAll(),
                        listadoCategorias: categoriaService.listarCategorias()]
                )
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPlato')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/platos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                plato.imagen = f.originalFilename
            }

            // Intentamos crear el plato
            platoService.actualizarPlato(plato)


        } catch (ValidationException e) {
            render(view: "platos", model: [
                    plato : plato,
                    listadoPlatos: Plato.findAll(),
                    listadoAlergenos: Alergeno.findAll(),
                    listadoCategorias: categoriaService.listarCategorias()]
            )
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.plato.actualizado.message")
        redirect(controller: "admin", action: "platos")
    }
}
