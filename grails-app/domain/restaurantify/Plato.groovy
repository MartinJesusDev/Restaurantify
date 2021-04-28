package restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que representa al Plato.
 * El Plato sera gestionado por el administrador del restaurante.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Plato {
    // Columnas
    String nombre
    String imagen = 'img_plato.png'
    Float precio
    Float descuento
    String elaboracion
    Float iva
    Integer tiempoElaboracion // Tiempo en segundos
    Boolean disponible = true

    // Relaciones
    static belongsTo = [
            categoria: Categoria
    ]

    static hasMany = [
            alergenos: Alergeno,
            valoraciones: Valoracion
    ]

    // Restricciones
    static constraints = {
        nombre size: 1..50, blank: false
        imagen blank: false
        precio min: 0F
        iva min: 0F
        tiempoElaboracion min: 0
        descuento blank: false
        elaboracion maxSize: 2000, blank: false
    }
}
