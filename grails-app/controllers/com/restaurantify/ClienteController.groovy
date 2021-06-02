package com.restaurantify

import grails.databinding.BindingFormat
import grails.validation.Validateable
import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

import static org.springframework.http.HttpStatus.CONFLICT
import static org.springframework.http.HttpStatus.CREATED

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
    MessageSource messageSource

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
        Boolean logueado
        try {
            logueado = clienteService.iniciarSesion(cl)
        } catch(Exception e) {
            flash.error = true
            flash.message = e.message
            render view: "login", model: [clienteLogin: cl]
            return
        }

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
     * Restablece el email de usuario indicado.
     */
    def adminResetPassword(String email) {
        try {
            // Intentamos envia un email para restablecer la contraseña
            clienteService.emailRestablecer(email)
        } catch(Exception e) {
            respond([message: e.message], status: CONFLICT, formats: ['json'])
            return
        }

        // Si fue bien mandamos el mensaje
        def msg = messageSource.getMessage("default.cliente.emailRestablecerEnviado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg ], status: CREATED, formats: ['json'])
    }

    /**
     * Bloquea o desbloquea un cliente.
     * @param id
     */
    def toggleBloqueoCliente(Long id) {
        Boolean bloqueado
        try {
            // Intentamos envia un email para restablecer la contraseña
            bloqueado = clienteService.toggleBloqueo(id)
        } catch(Exception e) {
            respond([message: e.message], status: CONFLICT, formats: ['json'])
            return
        }

        // Si fue bien mandamos el mensaje
        def msg
        if(bloqueado) {
            msg = messageSource.getMessage("default.cliente.bloqueado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        } else {
            msg = messageSource.getMessage("default.cliente.desbloqueado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        }
        respond([message: msg, bloqueado: bloqueado], status: CREATED, formats: ['json'])
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

    /**
     *
     * @param cf
     */
    def listar(ClienteFiltro cf) {
        Map clientes = clienteService.listar(cf)

        render(view: "gson/listaClientes", model: [
                clientes: clientes.lista,
                total: clientes.total,
                paginas: clientes.paginas
        ])
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

class ClienteFiltro implements Validateable {
    @BindingFormat("yyyy-MM-dd")
    Date fechaInicio

    @BindingFormat("yyyy-MM-dd")
    Date fechaFin

    String busqueda
    Integer offset
    String sort = "fecha"
    String order = "desc"


    static constraints = {
        busqueda nullable: true, blank: true
        fechaInicio nullable: true, blank: true
        fechaFin nullable: true, blank: true
        offset nullable: true, blank: true
        sort nullable: true, blank: true
        order nullable: true, blank: true
    }
}