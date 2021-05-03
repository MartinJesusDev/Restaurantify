package com.restaurantify

import grails.validation.ValidationException
import org.springframework.web.multipart.MultipartFile


import static org.springframework.http.HttpStatus.*

class ClienteController {
    ClienteService clienteService

    /**
     * Presenta la vista del registro.
     * Controla el registro del cliente.
     * @return
     */
    def registro(Cliente cliente) {
        // Muestra la vista del registro
        if (request.get) {
            return
        }

        try {
            // Comprobamos si hay errores
            if(cliente.hasErrors()) {
                render(view: "registro", model: [cliente : cliente])
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPerfil')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/clientes/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                cliente.imagen = f.originalFilename
            }

            // Intentamos crear el cliente
            clienteService.crearCliente(cliente)


        } catch (ValidationException e) {
            // Si hubo error cambiamos a la contraseña sin hash
            cliente.password = params.password

            render(view: "registro", model: [cliente : cliente])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.cliente.registrado.message")
        redirect(action: "registro")

        //render(view: "registro", params: new Cliente(params))
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
            cliente = Cliente.findById(session.cliente.getId())

            render(view: "perfil", model: [cliente : cliente])
            return
        }


        try {
            // Comprobamos si hay errores
            if(cliente.hasErrors()) {
                render(view: "perfil", model: [cliente : cliente])
                return
            }

            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPerfil')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/clientes/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                cliente.imagen = f.originalFilename
            } else {
                cliente.imagen = Cliente.findById(cliente.id).imagen
            }

            // Intentamos crear el cliente
            clienteService.actualizarCliente(cliente, params)


        } catch (ValidationException e) {
            // Si hubo error cambiamos a la contraseña sin hash
            cliente.password = params.password

            render(view: "perfil", model: [cliente : cliente])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.cliente.actualizado.message")
        redirect(action: "perfil", model: [cliente: cliente])

        //render(view: "registro", params: new Cliente(params))
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
            session.setAttribute("cliente", Cliente.findByEmail(cl.email))
            flash.message = message(code: "default.cliente.sesionIniciada.message")
            redirect(uri: "/")
            return
        } else {
            flash.message = message(code: "default.cliente.sesionNoIniciada.message" )
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
        Boolean verificado = clienteService.verificarCliente(params.email, params.token)

        // Mostramos un mensaje según su verificación
        flash.verificado = verificado
        if(verificado) {
            flash.message = message(code: "default.cliente.verificado.message")
        } else {
            flash.message = message(code: "default.cliente.no.verificado.message")
        }

        render view: "verificado", model: flash
    }

    /**
     * Imprime pantalla que indica que no se encontro el recurso.
     */
    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Cliente'), params.id])
        redirect(action: "index", render(status: NOT_FOUND))
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
