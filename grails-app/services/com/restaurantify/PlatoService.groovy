package com.restaurantify

import grails.gorm.transactions.Transactional

@Transactional
class PlatoService {

    /**
     * Inserta el plato en la base de datos.
     * @param p
     */
    void crearPlato(Plato p) {
        p.save()
    }

    /**
     * Actualiza el plato.
     * @param p
     */
    void actualizarPlato(Plato p) {
        p.save()
    }

    /**
     * Elimina el plato pasado por parametro.
     * @param p
     */
    void eliminarPlato(Plato p){
        p.delete()
    }
}
