package com.restaurantify

import grails.gorm.DetachedCriteria
import grails.gorm.transactions.Transactional
import org.grails.datastore.mapping.query.Query
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Cesta.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class PedidoService extends DefaultService{
    CestaService cestaService
    ClienteService clienteService

    MessageSource messageSource

    /**
     * Crea un pedido, con sus detalles, en la base de datos,
     * mediante la cesta del cliente.
     * También retira de la cesta los platos del cliente.
     * @return
     */
    @Transactional
    void completar(List<Cesta> cesta){
        Float gastosEnvioDefault = webSettingsService.obtenerAjustes().gastosDeEnvio as Float
        Float pedidoSuperior = webSettingsService.obtenerAjustes().gastosDeEnvioGratis as Float

        // Obtenemos el cliente
        Cliente c = clienteService.clienteSession()

        // Generamos la dirección del cliente
        String direccion = "$c.calle, $c.localidad, $c.provincia, $c.cp"

        // Creamos un pedido
        Pedido p = new Pedido(estado: 0, gastosEnvio: gastosEnvioDefault, total: 0, cliente: c, direccion: direccion)

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

        // Comprobamos los gastos de envio
        if(total >= pedidoSuperior) {
            p.gastosEnvio = 0
        }

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
     * @return
     */
    Map pedidosCliente(FiltroPedidosBasico fpb) {
        Integer max = webSettingsService.obtenerAjustes().pedidosPorPagina as Integer

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

        List<Pedido> pedidos = query.list([max: max, offset: fpb.offset * max, sort: "fecha", order: "desc"])
        return [total: total, lista: pedidos, paginas: totalPaginas]
    }

    /**
     * Lista las ventas del restaurante dados los filtros.
     * @param estado
     * @return
     */
    Map ventas(FiltroVentasAvanzado fva) {
        Integer max = webSettingsService.obtenerAjustes().ventasPorPagina as Integer

        // Obtenemos las ventas con los parametros
        DetachedCriteria<Pedido> query = Pedido.where {
            if(fva.cliente) {
                cliente {
                    or {
                        ilike('nombre', "%$fva.cliente%")
                        ilike('email', "%$fva.cliente%")
                    }
                }
            }

            eq('estado', 3)

            // Comprobamos la fecha deseada
            if(fva.fechaInicio && fva.fechaFin) {
                between('fecha', fva.fechaInicio, fva.fechaFin)
            } else {
                if (fva.fechaInicio) {
                    ge('fecha', fva.fechaInicio)
                } else if (fva.fechaFin) {
                    le('fecha', fva.fechaFin)
                }
            }

            // Comprobamos el total min y maximo
            if(fva.totalMin && fva.totalMax) {
                between('total', fva.totalMin, fva.totalMax)
            } else {
                if (fva.totalMin) {
                    ge('total', fva.totalMin)
                } else if (fva.totalMax) {
                    le('total', fva.totalMax)
                }
            }

        } as DetachedCriteria<Pedido>

        // Obtenemos varios totales
        Integer total = (Integer) query.count()
        Integer totalPaginas = (Integer) (total / max)

        List<Pedido> ventas = query.list([
                max: max,
                offset: fva.offset * max,
                sort: fva.sort,
                order: fva.order
        ])
        return [total: total, lista: ventas, paginas: totalPaginas]
    }

    /**
     * Cambia el estado de un pedido.
     * @param id
     * @param estado
     */
    @Transactional
    void cambiarEstado(PedidoCommand pc) {
        // Comprobamos si se quiere cambiar a un estado permitido
        Pedido pn = Pedido.get(pc.id)
        if(pn.estado != 0 && pc.estado == -1) {
            def msg = messageSource.getMessage('default.pedido.noModificado.message', [] as Object[], 'Default Message', LocaleContextHolder.locale)
            throw new Exception(msg)
        }

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
