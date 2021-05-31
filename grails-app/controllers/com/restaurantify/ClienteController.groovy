package com.restaurantify

import grails.validation.Validateable
import groovy.transform.CompileDynamic
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
        try {
            clienteService.crear(cliente)
        } catch(Exception e) {
            render(view: "registro",
                    model: [cliente : cliente])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.cliente.registrado.message"
        redirect(action: "registro")
    }

    /**
     * Presenta la vista del perfil.
     * Controla la actualización del cliente.
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

        try {
            // Intentamos actualizar el cliente
            clienteService.actualizar(cliente)
        } catch(Exception e) {
            render(view: "perfil",
                    model: [cliente : cliente])
            return
        }

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
     * Envia un mensaje a el correo de contacto.
     * @param cm
     */
    def contacto(ClienteMensaje cm) {
        // Muestra la vista del registro
        if(request.get) {
            return
        }

        // Comprobamos si hay errores
        if(cm.hasErrors()) {
            render(view: "contacto",
                    model: [clienteMensaje: cm])
            return
        }

        // Enviamos el mensaje de información
        try {
            clienteService.mensajeContacto(cm)
        } catch(Exception e) {
            render(view: "registro",
                    model: [clienteMensaje: cm])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.cliente.mensajeContacto.message"
        redirect(action: "contacto")
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

    /**
     * Imprime la pantalla para restablecer la contraseña.
     */
    def restablecer(String email) {
        if(request.get) {
            render view: "restablecer"
            return
        }

        try {
            // Intentamos envia un email para restablecer la contraseña
            clienteService.emailRestablecer(email)
        } catch(Exception e) {
            flash.error = true
            flash.message = e.message
            render view: "restablecer"
            return
        }

        flash.message = "default.cliente.emailRestablecerEnviado.message"
        redirect(action: "login")
    }


    /**
     * Imprime la pantalla para cambiar la contraseña del cliente. Y recibe los datos del formulario.
     * @param ClientePasswordReset
     */
    def resetPassword(ClientePasswordReset cpr) {
        if(request.get && (!params?.email || !params?.token)){
            redirect(uri: "/")
            return
        } else if(request.get) {
            Boolean valido = clienteService.validarTokenPassword()

            if(!valido) {
                flash.error = true
                flash.message = "default.passwordReset.tokenInvalido.message"
                redirect(action: "login")
                return
            }

            // Creamos un ClientePasswordReset con el email del cliente
            render view: "resetPassword", model: [email: params?.email]
            return
        }

        // Comprobamos si tiene errores
        if(cpr.hasErrors()) {
            render(view: "resetPassword", model: [
                    clientePasswordReset: cpr
            ])
            return
        }

        // Si no hay errores cambiamos la contraseña y mostramos mensaje
        clienteService.resetPassword(cpr)
        flash.message = "deafult.cliente.passwordCambiada.message"
        redirect(action: "login")
    }

    /**
     * Elimina la cluenta del cliente que esta en sessión.
     */
    def borrarCuenta() {
        try {
            // Obtenemos el cliente que esta en la sesión y lo borramos
            Cliente cli = clienteService.clienteSession()
            clienteService.borrar(cli.id)
            session.invalidate()
        } catch(Exception e) {
            redirect(controller: "cliente", action: "perfil")
            return
        }
        redirect(uri: "/", permanent: true)
    }
}

/**
 * Command object para facilitar el login.
 */
class ClienteLogin implements Validateable {
    String email
    String password

    static constraints = {
        email maxSize: 320, email: true, blank: false, unique: true
        password size: 6..255, blank: false, password: true
    }
}

class ClienteMensaje implements Validateable {
    String nombre
    String email
    String motivo
    String mensaje

    static constraints = {
        nombre blank: false
        email maxSize: 320, email: true, blank: false
        motivo blank: false
        mensaje blank: false, maxSize: 1000
    }
}

@CompileDynamic
class ClientePasswordReset implements Validateable {
    String email
    String password
    String repetPassword

    static constraints = {
        password size: 6..255, blank: false, password: true
        repetPassword size: 6..255, blank: false, password: true, validator: { value, obj, errors ->
            if(obj.password != value) {
                return errors.rejectValue('repetPassword', 'default.password.notmatch.message')
            }
        }
    }
}