package com.restaurantify

import groovy.transform.CompileStatic
import groovy.time.TimeCategory

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
    WebSettingsService webSettingsService

    static  defaultAction = "platos"

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
        render view: "ventas"
    }

    /**
     * Imprime la vista de los ajustes WEB.
     */
    def websettings(WebSettings ws) {
        if(!ws) {
            ws = webSettingsService.obtener()
        }

        render view: "webSettings", model: [
                webSettings: ws
        ]
    }

    /**
     * Imprime la vista de clientes.
     */
    def clientes() {
        render view: "clientes"
    }
}
