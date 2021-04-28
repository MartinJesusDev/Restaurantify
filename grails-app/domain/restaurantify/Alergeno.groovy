package restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que representa el Alergeno que contiene el Plato.
 * Este sera gestionado por el administrador del restaurante.
 * Un plato puede tener varios Alergenos.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Alergeno {
    // Columnas
    String nombre
    String imagen = "img_alergeno.png"

    // Restricciones
    static constraints = {
        nombre size: 1..50 , blank: false
        imagen blank: false
    }
}