package com.restaurantify

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Alergeno.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class AlergenoService extends DefaultService {

    /**
     * Inserta el alergeno en la base de datos.
     * @param a
     */
    @Transactional
    void crear(Alergeno a) {
        // Gestiona la imagen del alergeno
        uploadFileAlergeno(a)

        // Guarda el alergeno
        a.save()
    }

    /**
     * Actualiza el alergeno.
     * @param a
     */
    @Transactional
    void actualizar(Alergeno a) {
        // Gestiona la imagen del alergeno
        uploadFileAlergeno(a)

        // Guarda el alergeno
        a.save()
    }

    /**
     * Elimina el alergeno pasado por parametro.
     * @param a
     */
    @Transactional
    void eliminar(Alergeno a){
        // Elimina el alergeno
        a.delete()
    }

    /**
     * Retorna una lista con todos los alergenos.
     * @return Alergeno
     */
    List<Alergeno> listar () {
        return Alergeno.findAll()
    }

    /**
     * Controla la subida de una imagén del alergeno.
     */
    void uploadFileAlergeno(Alergeno alergeno) {
        try {
            // Guardamos el fichero si existe
            MultipartFile f = request.getFile('imagenAlergeno')
            if (!f.empty) {
                String imageUpload = grailsApplication.config.getProperty("grails.config.assetsPath")
                imageUpload += "images/alergenos/"
                f.transferTo(new File("${imageUpload}${f.originalFilename}"))
                alergeno.imagen = f.originalFilename
            }
        } catch(Exception e) {}
    }
}
