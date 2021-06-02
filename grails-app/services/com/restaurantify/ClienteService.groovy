package com.restaurantify

import at.favre.lib.crypto.bcrypt.BCrypt
import grails.gorm.DetachedCriteria
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
            from "soporte@servidor.edu"
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
                from "soporte@servidor.edu"
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
            cliente.token = null
            cliente.save()
            verificado = true
            session?.cliente?.verificado = true
        }

        return  verificado
    }

    /**
     * Compruba que dado el email y el token son validos.
     * @return Boolean true si el valido o false si no.
     */
    @Transactional
    Boolean validarTokenPassword() {
        Boolean valido = false

        // Buscamos el cliente
        Cliente cliente = Cliente.findByEmailAndToken(params?.email, params?.token)

        // Si es valido existira el cliente
        if(cliente) {
            valido = true
        }

        return valido
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
            // comprobamos si el cliente no esta bloqueado
            if(c.bloqueado) {
                throw new Exception("default.cliente.accesoBloqueado.message")
            }

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
    Map listar (ClienteFiltro cf) {
        Integer max = webSettingsService.obtenerAjustes().ventasPorPagina as Integer

        // Obtenemos los clientes con los parametros
        DetachedCriteria<Cliente> query = Cliente.where {
            // Comprobamos  el campo busqueda multiple
            if(cf.busqueda){
                or {
                    ilike('dni', "%$cf.busqueda%")
                    ilike('nombre', "%$cf.busqueda%")
                    ilike('apellidos', "%$cf.busqueda%")
                    ilike('email', "%$cf.busqueda%")
                }
            }

            // Comprobamos la fecha deseada
            if(cf.fechaInicio && cf.fechaFin) {
                between('fechaDeAlta', cf.fechaInicio, cf.fechaFin)
            } else {
                if (cf.fechaInicio) {
                    ge('fechaDeAlta', cf.fechaInicio)
                } else if (cf.fechaFin) {
                    le('fechaDeAlta', cf.fechaFin)
                }
            }

        } as DetachedCriteria<Cliente>

        // Obtenemos varios totales
        Integer total = (Integer) query.count()
        Integer totalPaginas = (Integer) (total / max)

        List<Cliente> clientes = query.list([
                max: max,
                offset: cf.offset * max,
                sort: cf.sort,
                order: cf.order
        ])
        return [total: total, lista: clientes, paginas: totalPaginas]
    }


    /**
     * Borra un cliente dado su id.
     * @param id
     */
    @Transactional
    void borrar(Long id) {
        Boolean borrado = Cliente.executeUpdate("delete from Cliente WHERE id = :id", [id: id])
        if(!borrado){
            throw new Exception("No se pudo borrar el cliente")
        }
    }

    /**
     * Envía un correo al email de contacto de la empresa.
     * @param cm
     */
    @Transactional
    void mensajeContacto(ClienteMensaje cm) {
        mailService.sendMail {
            to "contacto@servidor.edu"
            from "contacto@servidor.edu"
            subject "Contacto: Mensaje de cliente"
            html "<h1>Mensaje de $cm.nombre</h1><hr>" +
                    "<h3>Email: $cm.email</h3>" +
                    "<h3>Motivo: $cm.motivo</h3>" +
                    "<p>Mensaje: $cm.mensaje</p>"
        }
    }


    /**
     * Bloquea o desbloquea un cliente.
     * @param id
     * @return
     */
    @Transactional
    Boolean toggleBloqueo(Long id) {
        // Traemos el cliente, y cambiamos el estado de bloqueado
        Cliente c = Cliente.get(id)
        c.bloqueado = !c.bloqueado
        c.save()

        return c.bloqueado
    }

    /**
     * Envia un email con el enlace para restablecer la contraseña
     * @param email
     */
    @Transactional
    void emailRestablecer(String email) {
        // Comprobamos que existe el correo
        Cliente cli = Cliente.findByEmail(email)
        if(!cli) {
            throw new Exception("default.cliente.emailNoExiste.message")
        }

        // Generamos un token y mandamos el enlace al email
        String token = cli.email.encodeAsMD5()
        cli.token = token
        cli.save()
        mailService.sendMail {
            to cli.email
            from "soporte@servidor.edu"
            subject "Correo cambiar contraseña"
            html "Pulse en el enlace para restablecer su contraseña:" +
                    " <a href='http://localhost:8080/cliente/resetPassword?email=${email}&token=${token}'>Enlace cambiar contraseña</a>"
        }
    }

    /**
     * Cambia la contraseña del cliente
     * @param cpr
     */
    @Transactional
    void resetPassword(ClientePasswordReset cpr) {
        // Obtenemos el cliente con el correo
        Cliente cli = Cliente.findByEmail(cpr.email)

        // Generamos la contraseña e invalidamos el token
        String passwordHash = BCrypt.withDefaults().hashToString(12, cpr.password.toCharArray())
        cli.password = passwordHash
        cli.token = null

        // Guardamos el cliente
        cli.save()
    }

}
