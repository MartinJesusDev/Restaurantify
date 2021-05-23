package com.restaurantify

import groovy.transform.CompileStatic
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

import static org.springframework.http.HttpStatus.*

/**
 * Clase controlador para los Pedidos, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 17/05/2021
 * @version 1.0
 */
@CompileStatic
class PedidoController {
    PedidoService pedidoService
    CestaService cestaService
    MessageSource messageSource

    /**
     * Realiza el pedido mediante la cesta de la compra del usuario.
     * Imprime la página de pedidio completado si ha ido bien.
     */
    def completar() {
        // Obtenemos la cesta del cliente
        List<Cesta> cesta = cestaService.listar()

        // Si no tiene articulos en la cesta mandamos al index
        if(cesta.empty) {
            redirect(uri: "/")
            return
        }

        // Procedemos a realizar el pedido
        try {
            pedidoService.completar(cesta)
        } catch(Exception e) {
            redirect(controller: "cesta", action: "index")
            return
        }

        // Mostramos la vista del pedido realizado
        render(view: "completar")
    }


    /**
     * Muestra los pedidos pendientes de completar en el restaurante.
     */
    def pedidos(Integer estado) {
        List<Pedido> pedidos = pedidoService.pedidos(estado)

        render(view: "pendientes", model: [pedidos: pedidos])
    }

    /**
     * Modifica el estado de un pedido
     */
    def modificarEstado(PedidoCommand pc) {
        try {
            pedidoService.cambiarEstado(pc)
        } catch(Exception e) {
            respond([message: "BAD"], status: CONFLICT, formats: ['json'])
        }
        // Si fue bien mandamos el mensaje
        def msg = messageSource.getMessage("default.pedido.modificado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg ], status: OK, formats: ['json'])
    }

    /**
     * Imprime la pantalla que lista los pedidos para el restaurante.
     */
    def pedidosRestaurante() {
        render(view: "pedidos")
    }

}

class PedidoCommand {
    Long id
    Integer estado
}