package com.restaurantify

class BootStrap {

    def init = { servletContext ->
        println "Iniciando la aplicación."
    }

    def destroy = {
        println "Parando la aplicación."
    }
}
