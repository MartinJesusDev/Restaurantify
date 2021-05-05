package com.restaurantify

import grails.gorm.transactions.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class AlergenoService {

    /**
     * Inserta el alergeno en la base de datos.
     * @param a
     */
    void crearAlergeno(Alergeno a) {
        a.save()
    }

    /**
     * Actualiza el alergeno.
     * @param a
     */
    void actualizarAlergeno(Alergeno a) {
        a.save()
    }

    /**
     * Elimina el alergeno pasado por parametro.
     * @param a
     */
    void eliminarAlergeno(Alergeno a){
        a.delete()
    }
}
