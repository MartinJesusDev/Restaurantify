package com.restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que gestiona los detalles del Pedido.
 * Por cada plato de la Cesta, al realizar el pedido,
 * se creara una fila en la tabla, representada por esta clase.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class DetallesPedido {
    // Columnas
    String nombre
    Float precio
    Float descuento
    Float iva
    Integer unidades

    // Relaciones
    static belongsTo = [
            pedido : Pedido,
            plato : Plato
    ]

    // Restricciones
    static constraints = {
        nombre blank: false
        descuento min: 0F
        precio min: 0F
        iva min: 0F
        unidades min: 0
    }

    // Mapeado
    static mapping = {
        plato cascade: 'none'
    }
}