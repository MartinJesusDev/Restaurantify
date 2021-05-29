package com.restaurantify

import groovy.transform.CompileStatic

/**
 * Clase controlador para los Ajustes del restaurante.
 * Se encarga de configurar varios apartados personalizables de la web.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class WebSettingsController {
    WebSettingsService webSettingsService

    /**
     * Modifica los ajustes de la WEB.
     * @param ws
     */
    def modificar(WebSettings ws) {
        // Comprobamos si hay errores
        if(ws.hasErrors()) {
            render(view: "/admin/webSettings", model: [
                    webSettings: ws
            ])
            return
        }

        try {
            // Intentamos modificar el pedido
            webSettingsService.modificar(ws)
        } catch(Exception e) {
            render(view: "/admin/webSettings", model: [
                    webSettings: ws
            ])
            return
        }

        flash.message = "default.webSettings.actualizado.message"
        redirect(controller: "admin", action: "websettings")
    }
}
