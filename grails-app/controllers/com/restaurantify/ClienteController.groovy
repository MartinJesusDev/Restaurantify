package com.restaurantify

import groovy.transform.CompileStatic

/**
 * Clase controlador para los Clientes, que contrala las peticiones y errores.
 * Utiliza el servicio cliente para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class ClienteController {
    ClienteService clienteService

    /**
     * Presenta la vista del registro.
     * Controla el registro del cliente.
     */
    def registro(Cliente cliente) {
        // Muestra la vista del registro
        if (request.get) {
            return
        }

        // Comprobamos si hay errores
        if(cliente.hasErrors()) {
            render(view: "registro",
                    model: [cliente : cliente])
            return
        }

        // Intentamos crear el cliente
        clienteService.crear(cliente)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.cliente.registrado.message"
        redirect(action: "registro")
    }

    /**
     * Presenta la vista del perfil.
     * Controla la actualización del cliente.
     * @return
     */
    def perfil(Cliente cliente) {
        // Muestra la vista del perfil
        if (request.get) {
            // Obtenemos los datos del cliente dado el id en la sesión
            cliente = clienteService.clienteSession()

            render(view: "perfil",
                    model: [cliente : cliente])
            return
        }

        // Comprobamos si hay errores
        if(cliente.hasErrors()) {
            render(view: "perfil",
                    model: [cliente : cliente])
            return
        }

        // Intentamos crear el cliente
        clienteService.actualizar(cliente)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.cliente.actualizado.message"
        redirect(action: "perfil", model: [cliente: cliente])
    }

    /**
     * Presenta la vista del login.
     * Controla el login de un cliente.
     */
    def login(ClienteLogin cl) {
        // Muestra la vista del login
        if (request.get) {
            return
        }

        // Validamos los datos
        if(cl.hasErrors()){
            render view: "login", model: [clienteLogin: cl]
            return
        }

        // Validamos el cliente
        Boolean logueado = clienteService.iniciarSesion(cl)
        flash.error = !logueado
        if(logueado) {
            flash.message = "default.cliente.sesionIniciada.message"
            redirect(uri: "/")
            return
        } else {
            flash.message = "default.cliente.sesionNoIniciada.message"
        }

        // Redirigimos al login
        redirect(action: "login")

    }

     /**
     * Cierra la sesión y redirige a la página de inicio.
     */
    def logout() {
        session.invalidate()
        redirect(uri: "/")
    }

    /**
     * Controla la vista y verificación del correo del cliente.
     */
    def verificar() {
        // Verificamos el cliente
        Boolean verificado = clienteService.verificar()

        // Mostramos un mensaje según su verificación
        flash.verificado = verificado
        if(verificado) {
            flash.message = "default.cliente.verificado.message"
        } else {
            flash.message = "default.cliente.no.verificado.message"
        }

        render view: "verificado", model: flash
    }
}

/**
 * Command object para facilitar el login.
 */
class ClienteLogin {
    String email
    String password

    static constraints = {
        email maxSize: 320, email: true, blank: false, unique: true
        password size: 6..255, blank: false, password: true
    }
}
