package com.restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que representa la Categoría en la que esta el Plato.
 * Este sera gestionado por el administrador del restaurante.
 * Un plato solo tiene una Categoría.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Categoria {
    // Columnas
    String nombre
    Integer orden

    // Restricciones
    static constraints = {
        nombre size: 1..30, blank: false
        orden min: 1
    }
}
