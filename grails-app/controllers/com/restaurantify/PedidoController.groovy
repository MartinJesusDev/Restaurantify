package com.restaurantify

import groovy.transform.CompileStatic
import org.apache.commons.lang.RandomStringUtils

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

}
