package com.restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que representa las WebSettings (ajustes de la Web).
 * Permite al administrador del restaurante configurar varios apartados
 * del restaurante a su gusto, tanto en diseño como funcionalidad.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class WebSettings {
    // Columnas
    String nombre
    String color
    Integer alignTitulos
    Integer alignMenu
    Integer ventasPorPagina
    Integer pedidosPorPagina
    Integer valoracionesPorPagina
    String imgLogotipo
    Integer maxPlatosPedido
    Float gastosDeEnvio
    Float gastosDeEnvioGratis

    Map<String, String> listaColores = [
            '#B3A64A' : '#B3A64A',
            '#cc8424' : '#cc8424',
            '#B28ABF' : '#B28ABF',
            '#5BB4A5' : '#5BB4A5',
            '#962d2d' : '#962d2d'
    ]
    Map<Integer, String> alineacion = [
            0 : 'Izquieda',
            1 : 'Centro',
            2 : 'Derecha',
    ]

    Map obtenerAjustes() {
        Map alignFlexCSS = [
                0 : 'start',
                1 : 'center',
                2 : 'flex-end'
        ]

        Map alignTextCSS = [
                0 : 'left',
                1 : 'center',
                2 : 'right'
        ]

        // Creamos el mapa
        Map ajustes = [
                nombre: nombre,
                color: color,
                alignTitulos: alignTextCSS.get(alignTitulos),
                alignMenu: alignFlexCSS.get(alignMenu),
                ventasPorPagina: ventasPorPagina,
                pedidosPorPagina: pedidosPorPagina,
                valoracionesPorPagina: valoracionesPorPagina,
                imgLogotipo: imgLogotipo,
                maxPlatosPedido: maxPlatosPedido,
                gastosDeEnvio: gastosDeEnvio,
                gastosDeEnvioGratis: gastosDeEnvioGratis
        ]
    }

    // Variables no mapeadas
    static transients = ['listaColores', 'alineacion']

    // Restricciones
    static constraints = {
        nombre blank: false
        color blank: false
        alignTitulos inList: [0, // Izquierda
                              1, // Centro
                              2] // Derecha
        alignMenu inList: [0, // Izquierda
                              1, // Centro
                              2] // Derecha
        ventasPorPagina min: 1
        pedidosPorPagina min: 1
        valoracionesPorPagina min: 1
        imgLogotipo blank: false
        maxPlatosPedido min: 1
        gastosDeEnvio min: 0F
        gastosDeEnvioGratis min: 0F
    }

    // Mapeado y opciones para clase de Dominio
    static  mapping = {
        cache true
    }
}
