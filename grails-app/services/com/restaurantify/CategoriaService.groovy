package com.restaurantify

import grails.gorm.transactions.Transactional

@Transactional
class CategoriaService {

    /**
     * Inserta el categoría en la base de datos.
     * @param a
     */
    void crearCategoria(Categoria a) {
        a.save()
    }

    /**
     * Actualiza el categoría.
     * @param a
     */
    void actualizarCategoria(Categoria a) {
        a.save()
    }

    /**
     * Elimina el categoría pasado por parametro.
     * @param a
     */
    void eliminarCategoria(Categoria a){
        a.delete()
    }

    /**
     * Lista las categorias por su orden.
     * @return
     */
    List<Categoria> listarCategorias(){
        return Categoria.list([sort: "orden"])
    }
}
