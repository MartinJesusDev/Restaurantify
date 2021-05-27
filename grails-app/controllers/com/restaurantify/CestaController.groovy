package com.restaurantify

import groovy.transform.CompileStatic
import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

import static org.springframework.http.HttpStatus.*

/**
 * Clase controlador para la Cesta, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * En general es un controlador REST.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class CestaController  {
    CestaService cestaService
    MessageSource messageSource

    static allowedMethods = ["POST", "PUT", "DELETE", "GET"]
    static responseFormats = ["json"]

    /**
     * Imprime la vista de la cesta para el client actual.
     * Si no esta logueado redirige al index.
     */
    def index(){
        render(view: "cesta")
    }


    /**
     * Agrega a la cesta el plato y sus unidaes deseado por el cliente.
     * @param cesta
     */
    def agregar(Cesta cesta) {
        // Agregamos mediante el servio
        try {
            cestaService.agregar(cesta)
        } catch(Exception e){
            respond([message: e.message] , status: CONFLICT)
        }

        // Si fue bien mandamos el mensaje
        def msg = messageSource.getMessage("default.cesta.agregado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg ], status: CREATED)
    }

    /**
     * Quita unidades de la cesta. O lo elimina completamente.
     * @param cesta
     */
    def modificar(CestaCommand cesta){
        // Agregamos mediante el servio
        try {
            cestaService.modificar(cesta)
        } catch(Exception e){
            respond([message: e.message] , status: CONFLICT)
        }

        // Si fue bien mandamos el mensaje
        def msg = messageSource.getMessage("default.cesta.modificada.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg ], status: OK)
    }

    /**
     * Retorna un json con la lista de la cesta del cliente.
     */
    def listar(){
       List<Cesta> cesta = cestaService.listar()
        render(view: "lista", model: [lista: cesta])
    }

    /**
     * Elimina el plado de la cesta dado el idCesta.
     */
    def eliminar(CestaCommand cm){
        try {
            cestaService.eliminar(cm.id)
        } catch(Exception e) {
            respond([message: e.message], status: CONFLICT)
        }

        // Muestra
        def msg = messageSource.getMessage("default.cesta.eliminado.message", [] as Object[], 'Default Message', LocaleContextHolder.locale)
        respond([message: msg], status: OK)
    }

    /**
     * Crea un cesta para el cliente dado un id de pedido.
     * @param id
     */
    def nuevo(Long id) {
        try {
            cestaService.nueva(id)
            flash.message = "default.pedido.copiado.message"
            redirect(controller: "cesta", action: "index")
        } catch(Exception e) {
            flash.error = true
            flash.message = "default.pedido.noCopiado.message"
            redirect(controller: "cesta", action: "index")
        }
    }
}

class CestaCommand {
    Long id
    Integer unidades
}