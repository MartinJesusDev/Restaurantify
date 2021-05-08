package com.restaurantify

import groovy.transform.CompileStatic

/**
 * Clase controlador para las categorías, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class CategoriaController {
    CategoriaService categoriaService

    /**
     * Controla la creación de la categoría.
     * @param categoria
     */
    def crear(Categoria categoria) {

        // Comprobamos si hay errores
        if(categoria.hasErrors()) {
            render(view: "/admin/categorias",
                    model: [
                            categoria: categoria,
                            listadoCategorias: categoriaService.listar()
                    ])
            return
        }

        // Creamos la categoría
        categoriaService.crear(categoria)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.categoria.creado.message"
        redirect(controller: "admin", action: "categorias")
    }

    /**
     * Controla la eliminación del categoría.
     * @param categoria
     */
    def eliminar(Categoria categoria){
        if(!categoria.id) {
            render(view: "/admin/categorias",
                    model: [listadoCategorias: categoriaService.listar()])
            return
        }

        // Elimina la categoría
        categoriaService.eliminar(categoria)

        // Redirigimos y mostramos mensaje de eliminación
        flash.message = "default.categoria.eliminada.message"
        redirect(controller: "admin", action: "categorias")
    }

    /**
     * Controla la actualización de la categoría.
     * @param categoria
     */
    def actualizar (Categoria categoria) {

        // Comprobamos si hay errores
        if(categoria.hasErrors()) {
            render(view: "/admin/categorias",
                    model: [
                            categoria: categoria,
                            listadoCategorias: categoriaService.listar()
                    ])
            return
        }

        // Actualizamos la categoría
        categoriaService.actualizar(categoria)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.categoria.actualizada.message"
        redirect(controller: "admin", action: "categorias")
    }

}
