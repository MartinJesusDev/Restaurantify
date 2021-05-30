package com.restaurantify

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
}
