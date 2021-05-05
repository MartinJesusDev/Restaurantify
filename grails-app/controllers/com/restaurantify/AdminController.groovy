package com.restaurantify

class AdminController {

    /**
     * Controla la vista de estadisticas.
     */
    def index() {

    }

    /**
     * Controla la vista de alergenos.
     * @param id
     */
    def alergenos(Alergeno alergeno){
        render(view: "../alergeno/Alergenos", model: [listadoAlergenos: Alergeno.findAll(), alergeno: alergeno])
    }
}
