package com.restaurantify

import groovy.transform.ToString

import java.time.LocalDateTime

/**
 * Clase dominio, que representa los Pedidos.
 * Los pedidos son realizados por un Cliente y
 * gestionados por un administrador en el restaurante.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Pedido {
    // Columnas
    Integer estado
    Date fecha = new Date()
    Date fechaEntrega
    String direccion
    Float gastosEnvio
    Float total // Calculado mediante la totalidad del pedido

    // Relaciones
    static belongsTo = [cliente : Cliente]
    static hasMany = [detalles : DetallesPedido]

    // Restricciones
    static constraints = {
        estado inList: [-1,// Cancelado
                        0, // En aprobación del restaurante
                        1, // En proceso de preparación
                        2, // En reparto
                        3] // Completado
        fechaEntrega min: new Date(), nullable: true
        direccion blank: false
        gastosEnvio min: 0F
        total min: 0F
    }

    // Mapeado
    static mapping = {
        cliente cascade: 'none'
    }
}
