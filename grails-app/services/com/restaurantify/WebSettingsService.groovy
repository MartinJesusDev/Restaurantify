package com.restaurantify

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile


/**
 * Clase servicios que controla el acceso a base de datos para el Dominio WebSettings.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class WebSettingsService extends DefaultService {

    /**
     * Obtiene los ajustes del restaurante.
     * @return WebSettings
     */
    WebSettings obtener() {
        return WebSettings.load(1)
    }

    /**
     * Obtiene un mapa, con los ajustes de la WEB, preparados para utilizar.
     * @return
     */
    Map obtenerAjustes() {
        // Obtenemos los ajustes
        WebSettings ws = obtener()
        return ws.obtenerAjustes()
    }

    /**
     * Actualiza los ajustes web del restaurante.
     * @param ws
     */
    @Transactional
    void modificar(WebSettings ws) {
        // Comprobamos si se quiere subir una foto
        uploadFileWebSettings(ws)

        // Lo guardamos
        ws.save()
    }

    /**
     * Controla la subida de una imagén de la web.
     */
    void uploadFileWebSettings(WebSettings ws) {
        try {
            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagen')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/restaurante/"
                f.transferTo(new File("${imageUpload}logotipo.jpg"))
                ws.imgLogotipo = "logotipo.jpg"
            }
        } catch(Exception e) {}
    }
}
