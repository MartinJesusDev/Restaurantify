package com.restaurantify

import grails.gorm.transactions.Transactional

/**
 * Clase servicios que controla el acceso a base de datos para el Dominio Categoria.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
class CategoriaService extends DefaultService {

    /**
     * Inserta el categoría en la base de datos.
     * @param a
     */
    @Transactional
    void crear(Categoria a) {
        a.save()
    }

    /**
     * Actualiza el categoría.
     * @param a
     */
    @Transactional
    void actualizar(Categoria a) {
        a.save()
    }

    /**
     * Elimina el categoría pasado por parametro.
     * @param a
     */
    @Transactional
    void eliminar(Categoria a){
        a.delete()
    }

    /**
     * Lista las categorias por su orden.
     * @return
     */
    List<Categoria> listar(){
        return Categoria.listOrderByOrden()
    }
}
