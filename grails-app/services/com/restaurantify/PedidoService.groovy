package com.restaurantify

import grails.gorm.transactions.Transactional

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Cesta.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class PedidoService {
    CestaService cestaService
    ClienteService clienteService

    /**
     * Crea un pedido, con sus detalles, en la base de datos,
     * mediante la cesta del cliente.
     * También retira de la cesta los platos del cliente.
     * @return
     */
    @Transactional
    void completar(List<Cesta> cesta){
        // Obtenemos el cliente
        Cliente c = clienteService.clienteSession()

        // Creamos un pedido
        Pedido p = new Pedido(estado: 0, gastosEnvio: 3, total: 0, cliente: c)

        // Añadimos cada plato al detalle del pedido
        Float total = 0
        List<DetallesPedido> listaDP = []
        cesta.each {pc ->
            DetallesPedido dp = new DetallesPedido(
                    nombre: pc.plato.nombre,
                    precio: pc.plato.precio,
                    descuento: pc.plato.descuento,
                    iva: pc.plato.iva,
                    unidades: pc.unidades,
                    pedido: p,
                    plato: pc.plato
            )
            listaDP.add(dp)
            total += (pc.plato.total * dp.unidades)
        }
        // Añadimos los detalles al pedido
        p.detalles = listaDP

        // Modificamos el total del pedido y guardamos
        p.total = (Float) (total + p.gastosEnvio).round(2)
        p.save()

        // Vaciamos la cesta del cliente
        cestaService.vaciar()
    }
}
