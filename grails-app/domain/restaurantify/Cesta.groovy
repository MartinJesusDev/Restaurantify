package restaurantify

import groovy.transform.ToString

/**
 * Clase dominio, que representa a la Cesta.
 * En la cesta se guardan los Platos que desea el Cliente,
 * para después proceder a realizar el Pedido.
 * Este sera gestionado por el Cliente.
 * @author Martín Jesús Mañas Rivas
 * @since 5/04/2021
 * @version 1.0
 */
@ToString
class Cesta {
    // Columnas
    Integer unidades

    // Relaciones
    static belongsTo = [
            cliente : Cliente,
            plato : Plato
    ]

    // Restricciones
    static constraints = {
        unidades min: 1
    }
}
