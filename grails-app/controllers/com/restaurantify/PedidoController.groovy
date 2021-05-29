package com.restaurantify

import grails.databinding.BindingFormat
import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

import java.time.LocalDateTime

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
     * Muestra los pedidos pendientes de completar en el restaurante.
     */
    def pedidosCliente(FiltroPedidosBasico fpb) {
        Map pedidos = pedidoService.pedidosCliente(fpb)

        render(view: "listaPedidos", model: [
                pedidos: pedidos.lista,
                total: pedidos.total,
                paginas: pedidos.paginas
        ])
    }

    /**
     * Cancela el pedido de un cliente dado el id.
     * @return
     */
    def cancelar(Long id) {
        PedidoCommand pc = new PedidoCommand(id: id, estado: -1)
        pedidoService.cambiarEstado(pc)
        redirect(controller: "pedido", action: "misPedidos")
    }

    /**
     * Modifica el estado de un pedido
     */
    def modificarEstado(PedidoCommand pc) {
        try {
            pedidoService.cambiarEstado(pc)
        } catch(Exception e) {
            respond([message: e], status: CONFLICT, formats: ['json'])
        }
        // Si fue bien mandamos el mensaje
        def msg = messageSource.getMessage("default.pedido.modificado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg ], status: OK, formats: ['json'])
    }

    /**
     * Imprime la pantalla que lista los pedidos para el restaurante.
     */
    def pedidosRestaurante() {
        render(view: "pedidosRestaurante")
    }

    /**
     * Imprime la pantlla que muestra los pedidos del cliente.
     */
    def misPedidos() {
        render(view: "pedidosCliente")
    }

    /**
     * Imprime un JSON con las ventas.
     */
    def ventas(FiltroVentasAvanzado fva) {
        Map ventas = pedidoService.ventas(fva)

        render(view: "listaPedidos", model: [
                pedidos: ventas.lista,
                total: ventas.total,
                paginas: ventas.paginas
        ])
    }

}

class PedidoCommand {
    Long id
    Integer estado
}

class FiltroPedidosBasico {
    @BindingFormat("yyyy-MM-dd")
    Date fechaInicio

    @BindingFormat("yyyy-MM-dd")
    Date fechaFin
    Integer estado
    Integer offset

    static constraints = {
        fechaInicio nullable: true, blank: true
        fechaFin nullable: true, blank: true
        estado nullable: true, blank: true
        offset nullable: true, blank: true
    }
}

class FiltroVentasAvanzado {
    String cliente
    Float totalMin
    Float totalMax

    @BindingFormat("yyyy-MM-dd")
    Date fechaInicio

    @BindingFormat("yyyy-MM-dd")
    Date fechaFin
    Integer offset
    String sort = "fecha"
    String order = "desc"

    static constraints = {
        cliente nullable: true, blank: true
        totalMin nullable: true, blank: true
        totalMax nullable: true, blank: true
        fechaInicio nullable: true, blank: true
        fechaFin nullable: true, blank: true
        offset nullable: true, blank: true
        sort nullable: true, blank: true
        order nullable: true, blank: true
    }
}