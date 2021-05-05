package com.restaurantify

import grails.validation.ValidationException
import org.springframework.web.multipart.MultipartFile

class AlergenoController {
    AlergenoService alergenoService

    /**
     * Controla la creación del alergeno.
     */
    def crear(Alergeno alergeno) {
        try {
            // Comprobamos si hay errores
            if(alergeno.hasErrors()) {
                render(view: "Alergenos", model: [alergeno : alergeno, listadoAlergenos: Alergeno.findAll()])
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenAlergeno')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/alergenos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                alergeno.imagen = f.originalFilename
            }

            // Intentamos crear el alergeno
            alergenoService.crearAlergeno(alergeno)


        } catch (ValidationException e) {
            render(view: "Alergenos", model: [alergeno : alergeno, listadoAlergenos: Alergeno.findAll()])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.alergeno.creado.message")
        redirect(controller: "admin", action: "alergenos")
    }

    /**
     * Controla la eliminación del alergeno.
     */
    def eliminar(Alergeno alergeno){
        if(!alergeno.id) {
            render(view: "Alergenos", model: [listadoAlergenos: Alergeno.findAll()])
            return
        }

        alergenoService.eliminarAlergeno(alergeno)

        flash.message = message(code: "default.alergeno.eliminado.message")
        redirect(controller: "admin", action: "alergenos")
    }

    /**
     * Controla la actualización del alergeno.
     */
    def actualizar (Alergeno alergeno) {
        try {
            // Comprobamos si hay errores
            if(alergeno.hasErrors()) {
                render(view: "Alergenos", model: [alergeno : alergeno, listadoAlergenos: Alergeno.findAll()])
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenAlergeno')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/alergenos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                alergeno.imagen = f.originalFilename
            }

            // Intentamos crear el alergeno
            alergenoService.actualizarAlergeno(alergeno)


        } catch (ValidationException e) {
            render(view: "Alergenos", model: [alergeno : alergeno, listadoAlergenos: Alergeno.findAll()])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.alergeno.actualizado.message")
        redirect(controller: "admin", action: "alergenos")
    }
}
