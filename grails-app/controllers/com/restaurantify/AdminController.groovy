package com.restaurantify

class AdminController {
    CategoriaService categoriaService

    /**
     * Controla la vista de estadisticas.
     */
    def index() {

    }

    /**
     * Controla la vista de alergenos.
     * @param id
     */
    def alergenos(Alergeno alergeno){
        render(view: "../alergeno/Alergenos", model: [listadoAlergenos: Alergeno.findAll(), alergeno: alergeno])
    }

    /**
     * Controla la vista de categorías.
     * @param categoria
     */
    def categorias(Categoria categoria) {
        render(view: "../categoria/Categorias", model: [listadoCategorias: categoriaService.listarCategorias(), categoria: categoria])
    }
}
