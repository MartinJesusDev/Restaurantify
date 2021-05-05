package com.restaurantify

import grails.validation.ValidationException

class CategoriaController {
    CategoriaService categoriaService

    /**
     * Controla la creación del categoría.
     */
    def crear(Categoria categoria) {
        try {
            // Comprobamos si hay errores
            if(categoria.hasErrors()) {
                render(view: "Categorias", model: [categoria : categoria, listadoCategorias: categoriaService.listarCategorias()])
                return
            }

            // Intentamos crear el categoria
            categoriaService.crearCategoria(categoria)

        } catch (ValidationException e) {
            render(view: "Categorias", model: [categoria : categoria, listadoCategorias: categoriaService.listarCategorias()])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.categoria.creado.message")
        redirect(controller: "admin", action: "categorias")
    }

    /**
     * Controla la eliminación del categoría.
     */
    def eliminar(Categoria categoria){
        if(!categoria.id) {
            render(view: "Categorias", model: [listadoCategorias: categoriaService.listarCategorias()])
            return
        }

        // Elimina la categoria e imprime mensaje
        categoriaService.eliminarCategoria(categoria)
        flash.message = message(code: "default.categoria.eliminada.message")
        redirect(controller: "admin", action: "categorias")
    }

    /**
     * Controla la actualización de la categoría.
     */
    def actualizar (Categoria categoria) {
        try {
            // Comprobamos si hay errores
            if(categoria.hasErrors()) {
                render(view: "Categorias", model: [categoria : categoria, listadoCategorias: categoriaService.listarCategorias()])
                return
            }

            // Intentamos actualizar la categoría
            categoriaService.actualizarCategoria(categoria)


        } catch (ValidationException e) {
            render(view: "Categorias", model: [categoria : categoria, listadoCategorias: categoriaService.listarCategorias()])
            return
        }

        // Redirigimos y mostramos mensaje correcto
        flash.message = message(code: "default.categoria.actualizada.message")
        redirect(controller: "admin", action: "categorias")
    }

}
