package restaurantify

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
    String nombre = "Restaurantify"
    String color = "#641c34"
    Integer alignTitulos = 0
    Integer platosPorPagina = 5
    Integer pedidosPorPagina = 5
    String imgPortada = 'img_portada.png'
    String imgLogotipo = 'img_logotipo.png'
    Integer maxPlatosPedido = 10
    Float gastosDeEnvio = 3.90
    Float gastosDeEnvioGratis = 50

    // Restricciones
    static constraints = {
        nombre blank: false
        color blank: false
        alignTitulos inList: [0, // Izquierda
                              1, // Centro
                              2] // Derecha
        platosPorPagina min: 1
        pedidosPorPagina min: 1
        imgPortada blank: false
        imgLogotipo blank: false
        maxPlatosPedido min: 1
        gastosDeEnvio min: 0F
        gastosDeEnvioGratis min: 0F
    }
}
