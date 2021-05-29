package com.restaurantify

import groovy.transform.CompileStatic

@CompileStatic
class InicioController {
    WebSettingsService webSettingsService

    /**
     * Imprime la pantalla de inicio.
     */
    def index() {
        render view: "/index"
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
}
