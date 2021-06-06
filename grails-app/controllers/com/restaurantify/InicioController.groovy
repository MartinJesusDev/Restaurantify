package com.restaurantify

import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic

@CompileStatic
class InicioController {
    WebSettingsService webSettingsService
    PlatoService platoService

    /**
     * Imprime la pantalla de inicio.
     */
    def index() {
        List<Plato> platos = platoService.platosMasPedidos()

        render view: "/index", model: [
                listaPlatos: platos
        ]
    }

    /**
     * Imprime la pantalla de error.
     */
    def error() {
        render view: "/error"
    }

    /**
     * Imprime la pantalla de no encontrado.
     */
    def notFound() {
        render view: "/notFound"
    }

    /**
     * Imprime el pdf de ayuda.
     */
    @CompileDynamic
    def ayuda() {
        String documentsPath = grailsApplication.config.getProperty("grails.config.docsPath")
        File fileToReturn = new File(documentsPath + "manual_del_usuario.pdf")
        render(contentType: "application/pdf", file: fileToReturn)
    }
}
