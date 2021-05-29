package com.restaurantify

import grails.gorm.transactions.Transactional
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder


/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Cesta.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class CestaService extends DefaultService{
    MessageSource messageSource
    ClienteService clienteService

    /**
     * Inserta las unidades del plato en la base de datos.
     * @param vc
     */
    @Transactional
    void agregar(Cesta cesta) {
        Integer maxUnidades = webSettingsService.obtenerAjustes().maxPlatosPedido as Integer

        // Comprobamos si ya existe en la DDBB
        Cesta cdb = Cesta.findByPlatoAndCliente(cesta.plato, cesta.cliente)
        if(cdb){
            // Agregamos las nuevas unidades a la cesta
            // Si no se supera el maximo de unidades permitidas
            Integer ud = cdb.unidades + cesta.unidades
            if(ud > maxUnidades) {
                def msg = messageSource.getMessage('default.cesta.errorMaxUnidades.message', [maxUnidades] as Object[], 'Default Message', LocaleContextHolder.locale)
                throw new Exception(msg)
            }

            // Guardamos con el total de unidades
            cdb.unidades = ud
            cdb.save()
        } else {
            // Simplemente guardamos en la cesta
            cesta.save()
        }
    }

    /**
     * Cambia las unidades de la cesta, sumando o restandolas.
     * Si se llega a 0 unidades se elimina de la cesta.
     */
    @Transactional
    void modificar(CestaCommand cm){
        Integer maxUnidades = webSettingsService.obtenerAjustes().maxPlatosPedido as Integer

        // Obtenemos la cesta en la base de datos
        Cesta cdb = Cesta.findById(cm.id)

        // Si es 0 se borrara de la cesta
        if(cm.unidades == 0) {
            // Elimina mediante el servicio
            eliminar(cdb.id)
            return
        }

        // Si no agregamos
        if(cm.unidades > maxUnidades) {
            def msg = messageSource.getMessage('default.cesta.errorMaxUnidades.message', [maxUnidades] as Object[], 'Default Message', LocaleContextHolder.locale)
            throw new Exception(msg)
        }

        // Guardamos con el total de unidades
        cdb.unidades = cm.unidades
        cdb.save()
    }

    /**
     * Elimina un plato de la cesta dado el id.
     * @param id
     */
    @Transactional
    void eliminar(Long id){
        Long idCliente = clienteService.clienteSession().id

        Boolean eliminado = Cesta.executeUpdate(
                "delete from Cesta where id = :id and cliente_id = :idCliente" ,
                [id: id, idCliente: idCliente]
        )

        // Comprobamos si se elimino
        if(!eliminado) {
            def msg = messageSource.getMessage('default.cesta.noEliminado.message', [] as Object[], 'Default Message', LocaleContextHolder.locale)
            throw new Exception(msg)
        }
    }

    /**
     * Retira todos los platos de la cesta del cliente.
     */
    @Transactional
    void vaciar() {
        // Obtenemos el cliente
        Cliente c = clienteService.clienteSession()

        // Ejecutamos la consulta que vacía la cesta
        Cesta.executeUpdate("delete from Cesta where cliente_id = :id", [id: c.id])
    }

    /**
     * Retorna la lista de platos de la cesta del cliente.
     * Ordena por id para mostrar un listado con el mismo orden.
     */
    List<Cesta> listar() {
        return Cesta.findAllByCliente(clienteService.clienteSession()).sort {it?.id}
    }

    /**
     * Crea una nueva cesta apartir de un pedido.
     * @param id
     */
    @Transactional
    void nueva(Long id) {
        // Vaciamos la cesta
        vaciar()

        // Obtenemos el cliente
        Cliente cli  = clienteService.clienteSession()

        // OBtenemos el pedido
        Pedido p = Pedido.get(id)

        // Recorremos los detalles del pedido y añadimos a la cesta
        p.detalles.each {dp ->
            // Comprobamos si existe el plato y si esta disponible
            if(Plato.exists(dp.plato.id) && Plato.load(dp.plato.id).disponible) {
                new Cesta(cliente: cli, plato: dp.plato, unidades: dp.unidades).save()
            }
        }

    }
}
