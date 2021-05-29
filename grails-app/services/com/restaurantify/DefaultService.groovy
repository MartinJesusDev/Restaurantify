package com.restaurantify

import grails.web.Controller

/**
 * Servicio generico que permite el acceso a varios apartados del ServletContext y otras..
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@Controller
class DefaultService implements grails.artefact.Controller {
    WebSettingsService webSettingsService
}
