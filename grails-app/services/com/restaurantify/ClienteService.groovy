package com.restaurantify

import at.favre.lib.crypto.bcrypt.BCrypt
import grails.gorm.transactions.Transactional
import grails.plugins.mail.MailService
import org.springframework.web.multipart.MultipartFile

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Cliente.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class ClienteService  extends DefaultService{
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
    void crear(Cliente cliente) {
        // Generamos un token aleatorio
        String token = cliente.email.encodeAsMD5()
        cliente.token = token

        // Encriptamos la contraseña del cliente
        String passwordHash = BCrypt.withDefaults().hashToString(12, cliente.password.toCharArray())
        cliente.password = passwordHash

        // Comprobamos si subío imagen
        uploadFileCliente(cliente)

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
    void actualizar(Cliente cliente) {
        // Obtenemos el antiguo cliente
        Cliente oldCli = Cliente.findById(cliente.id)

        // Encriptamos la contraseña del cliente si existe
        if(params.oldPassword != cliente.password) {
            String passwordHash = BCrypt.withDefaults().hashToString(12, cliente.password.toCharArray())
            cliente.password = passwordHash
        }

        // Comprobamos si subío imagen
        uploadFileCliente(cliente)

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

        // Comprobamos si la actualización la hizo el usuario para actualizar los datos en sessión
        if(session?.cliente?.id == cliente.id){
            session.setAttribute("cliente", Cliente.findById(cliente.id))
        }
    }

    /**
     * Verifica el correo del cliente.
     */
    @Transactional
    Boolean verificar(){
        Boolean verificado = false

        // Buscamos el cliente
        Cliente cliente = Cliente.findByEmailAndToken(params?.email, params?.token)

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

        // Si se logueo lo guardamos en sessión
        if (logueado) {
            session.setAttribute("cliente", Cliente.findByEmail(cl.email))
        }


        return logueado
    }

    /**
     * Controla la subida de una imagén del cliente.
     */
    void uploadFileCliente(Cliente cliente) {
        try {
            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenPerfil')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/clientes/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                cliente.imagen = f.originalFilename
            }
        } catch(Exception e) {}
    }

    /**
     * Retorna el cliente que se ha guardado en la session.
     * @return Cliente
     */
    Cliente clienteSession(){
        return Cliente.findById(session?.cliente?.id)
    }

    /**
     * Retorna una lista con todos los clientes.
     * @return Cliente
     */
    List<Cliente> listar () {
        return Cliente.findAll()
    }

}
