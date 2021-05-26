package com.restaurantify

import grails.gorm.DetachedCriteria
import grails.gorm.transactions.Transactional
import org.grails.datastore.mapping.query.Query

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

        // Generamos la dirección del cliente
        String direccion = "$c.calle, $c.localidad, $c.provincia, $c.cp"

        // Creamos un pedido
        Pedido p = new Pedido(estado: 0, gastosEnvio: 3, total: 0, cliente: c, direccion: direccion)

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

    /**
     * Obtenemos la lista de pedidos.
     * Se considera un pedido, aquellos que su estado no es,
     * ni -1 "cancelado", ni 4 "completado".
     * @return
     */
    List<Pedido> pedidos(Integer estado) {
        // Obtenemos los pedidos
        List<Pedido> pedidos = Pedido.where {
            estado == estado
        }.list(sort: "fecha") as List<Pedido>

        return pedidos
    }

    /**
     *  Lista los pedidos del cliente dados unos parametros de busqueda.
     * @param estado
     * @return
     */
    Map pedidosCliente(FiltroPedidosBasico fpb, max = 10) {
        // Obtenemos el cliente que pide los datos
        Cliente cli = clienteService.clienteSession()

        // Obtenemos los pedidos
        DetachedCriteria<Pedido> query = Pedido.where {
            cliente {
                eq 'id', cli.id
            }
        } as DetachedCriteria

        // Comprobamos si especifico el estado
        if(fpb.estado != null) {
            query = query.where {eq 'estado', fpb.estado}
        }

        /**
         * Comprobamos si especifico ambas fechas
         */
        if(fpb.fechaInicio && fpb.fechaFin) {
            query = query.where {
                  between 'fecha', fpb.fechaInicio, fpb.fechaFin +1
            }
        } else {
            // Comprobamos si tiene al menos una
            if (fpb.fechaInicio) {
                query = query.where {ge 'fecha', fpb.fechaInicio}
            } else if (fpb.fechaFin) {
                query = query.where {le 'fecha', fpb.fechaFin}
            }
        }

        // Obtenemos varios totales
        Integer total = (Integer) query.count()
        Integer totalPaginas = (Integer) (total / max)

        List<Pedido> pedidos = query.list([max: max, offset: fpb.offset, sort: "fecha", order: "desc"])
        return [total: total, lista: pedidos, paginas: totalPaginas]
    }

    /**
     * Cambia el estado de un pedido.
     * @param id
     * @param estado
     */
    @Transactional
    void cambiarEstado(PedidoCommand pc) {
        // Cambiamos el estado del pedido.
        Pedido.where {
            id == pc.id
        }.updateAll(estado: pc.estado)

        // Si se ha completado el pedido guardamos la fecha de entra
        if(pc.estado == 3) {
            Pedido.where {
                id == pc.id
            }.updateAll(fechaEntrega: new Date())
        }
    }
}
