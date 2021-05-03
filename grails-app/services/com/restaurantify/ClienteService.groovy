package com.restaurantify

import at.favre.lib.crypto.bcrypt.BCrypt
import grails.gorm.transactions.Transactional
import grails.plugins.mail.MailService

class ClienteService {
    MailService mailService

    /**
     * Inserta el cliente en la base de datos.
     * Genera un token unico.
     * Realiza un hash a la contraseña.
     * Envia un correo para verificar su correo.
     * @param cliente
     * @return
     */
    @Transactional
    void crearCliente(Cliente cliente) {
        // Generamos un token aleatorio
        String token = cliente.email.encodeAsMD5()
        cliente.token = token

        // Encriptamos la contraseña del cliente
        String passwordHash = BCrypt.withDefaults().hashToString(12, cliente.password.toCharArray())
        cliente.password = passwordHash

        // Guardamos el cliente
        cliente.save()

        // Enviamos el correo
        mailService.sendMail {
            to cliente.email
            from "admin@servidor.edu"
            subject "Correo de verificación"
            html "Pulse en el enlace para verificar su correo:" +
                    " <a href='http://localhost:8080/cliente/verificar?email=${cliente.email}&token=${token}'>Enlace verificación</a>"
        }
    }

    /**
     * Actualiza los datos basicos del cliente.
     * @param cliente
     * @return
     */
    @Transactional
    void actualizarCliente(Cliente cliente, def params) {
        // Obtenemos el antiguo cliente
        Cliente oldCli = Cliente.findById(cliente.id)

        // Encriptamos la contraseña del cliente si existe
        if(params.oldPassword != cliente.password) {
            String passwordHash = BCrypt.withDefaults().hashToString(12, cliente.password.toCharArray())
            cliente.password = passwordHash
            println passwordHash
        }

        // Guardamos el cliente
        cliente.save()

        // Enviamos el correo si cambio el email
        if (cliente.email != params.oldEmail) {
            cliente.verificado = false
            mailService.sendMail {
                to cliente.email
                from "admin@servidor.edu"
                subject "Correo de verificación"
                html "Pulse en el enlace para verificar su nuevo correo:" +
                        " <a href='http://localhost:8080/cliente/verificar?email=${cliente.email}&token=${cliente.token}'>Enlace verificación</a>"
            }
        }
    }

    /**
     * Verifica el correo del cliente.
     */
    @Transactional
    Boolean verificarCliente(String email, String token){
        Boolean verificado = false

        // Buscamos el cliente
        Cliente cliente = Cliente.findByEmailAndToken(email, token)

        // Lo verificamos si existe
        if(cliente) {
            cliente.verificado = true
            cliente.save()
            verificado = true
        }

        return  verificado
    }


    /**
     * Comprueba si el cliente es valido.
     * Lo guarda en la sesión.
     */
    @Transactional
    Boolean iniciarSesion(ClienteLogin cl){
        Boolean logueado = false

        // Obtenemos el cliente con ese email
        Cliente c = Cliente.findByEmail(cl.email)

        // Si no es nulo comprobamos la contraseña
        if (c){
            BCrypt.Result result = BCrypt.verifyer().verify(cl.password.toCharArray(), c.password)
            logueado = result.verified
        }


        return logueado
    }

}
