package com.restaurantify

import groovy.transform.CompileStatic

/**
 * Clase controlador para la administración, que contrala las peticiones y errores.
 * Gestiona varios Dominios ya que se trada de la clase de Administrador.
 * Utiliza varios servicios.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class AdminController {
    CategoriaService categoriaService
    AlergenoService alergenoService
    PlatoService platoService

    /**
     * Controla la vista de estadisticas.
     */
    def index() {

    }

    /**
     * Controla la vista de alergenos.
     * @param alergeno
     */
    def alergenos(Alergeno alergeno){
        render(view: "alergenos",
                model: [
                        listadoAlergenos: alergenoService.listar(),
                        alergeno: alergeno
                ])
    }

    /**
     * Controla la vista de categorías.
     * @param categoria
     */
    def categorias(Categoria categoria) {
        render(view: "categorias",
                model: [
                        listadoCategorias: categoriaService.listar(),
                        categoria: categoria
                ])
    }

    /**
     * Controla la vista de platos.
     * @param plato
     */
    def platos(Plato plato){
        render(view: "platos",
                model: [
                    listadoPlatos: platoService.listar(),
                    listadoAlergenos: alergenoService.listar(),
                    listadoCategorias: categoriaService.listar(),
                    plato: plato
                ])
    }

    /**
     * Imprime las vista de las ventas.
     */
    def ventas() {

    }
}
