package com.restaurantify

import groovy.transform.ToString

import java.time.LocalDate

/**
 * Clase dominio, que representa la Valoración del Plato.
 * Las Valoraciones son creadas por Clientes.
 * El administrador del servidor puede gestionar las Valoraciones.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Valoracion {
    // Columnas
    Integer puntuacion
    String comentario
    LocalDate fecha = LocalDate.now()

    // Relaciones
    static belongsTo = [
            cliente: Cliente,
            plato: Plato
    ]

    // Restricciones
    static constraints = {
        puntuacion range: 1..10, blank: false
        comentario maxSize: 1000
        fecha date: true, max: LocalDate.now(), blank: false
    }
}
