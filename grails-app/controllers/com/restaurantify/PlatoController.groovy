package com.restaurantify


import groovy.transform.CompileStatic

/**
 * Clase controlador para los Platos, que contrala las peticiones y errores.
 * Utiliza los servicios correspondientes para su funcionamiento.
 * @author Martín Jesús Mañas Rivas
 * @since 10/04/2021
 * @version 1.0
 */
@CompileStatic
class PlatoController {
    PlatoService platoService
    CategoriaService categoriaService
    AlergenoService alergenoService
    ValoracionService valoracionService
    ClienteService clienteService


    /**
     * Lista los platos dado una páginación, filtros y rangos.
     */
    def lista(FiltroPlatos filtroPlatos){
        // Obtenemos el listado de platos
        List<Plato> listadoPlatos
        try {
            listadoPlatos = platoService.listadoFiltrado(filtroPlatos)
        } catch(Exception e) {
            println e
            listadoPlatos = []
        }

        // Recorremos las categorias y le asignamos sus platos
        List<CategoriaConPlatos> categoriaConPlatos = []
        filtroPlatos.categorias.each {categoria ->
            List<Plato> platosTmp
            platosTmp = listadoPlatos.findAll {it.categoria.id == categoria.id}

            // Si existe algún plato para la categoría
            if(platosTmp) {
                categoriaConPlatos += new CategoriaConPlatos(categoria, platosTmp)
                println categoria.nombre
            }
        }

        // Ordenamos según el orden de la categoria
        categoriaConPlatos.sort({it.orden})

        render(view: "listaPlatos",
                model: [
                        filtro: filtroPlatos,
                        categoriasConPlatos: categoriaConPlatos,
                        listadoAlergenos: alergenoService.listar(),
                        listadoCategorias: categoriaService.listar(),
                ])
    }

    /**
     * Muestra la vista del plato dado su id.
     */
    def show(Plato plato) {
        // Comprueba si se dio el id del plato
        if(plato?.id == null) {
            redirect(controller: "plato", action: "lista")
            return
        }

        // Obtenemos la valoración del cliente para el plato, si existe..
        Cliente c = clienteService.clienteSession()
        Valoracion vcli
        if (c != null) {
            vcli = valoracionService.findByClienteAndPlato(c, plato)
        }

        // IMprime la vista de valoraciones
        render([view: "plato",
            model: [
                    plato: plato,
                    valoraciones: valoracionService.listar(plato),
                    miValoracion: vcli
            ]
        ])
    }

    /**
     * Controla la creación del plato.
     */
    def crear(Plato plato) {
        // Comprobamos si hay errores
        if(plato.hasErrors()) {
            render(view: "/admin/platos",
                    model: [
                        listadoPlatos: platoService.listar(),
                        listadoAlergenos: alergenoService.listar(),
                        listadoCategorias: categoriaService.listar(),
                        plato: plato
                    ])
            return
        }

        // Intentamos crear el plato
        platoService.crear(plato)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.plato.creado.message"
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la eliminación del plato.
     */
    def eliminar(Plato plato){
        if(!plato.id) {
            render(view: "/admin/platos",
                    model: [
                            listadoPlatos: platoService.listar(),
                            listadoAlergenos: alergenoService.listar(),
                            listadoCategorias: categoriaService.listar(),
                    ])
            return
        }

        platoService.eliminar(plato)

        flash.message = "default.plato.eliminado.message"
        redirect(controller: "admin", action: "platos")
    }

    /**
     * Controla la actualización del plato.
     */
    def actualizar (Plato plato) {
        // Comprobamos si hay errores
        if(plato.hasErrors()) {
            render(view: "/admin/platos",
                    model: [
                            listadoPlatos: platoService.listar(),
                            listadoAlergenos: alergenoService.listar(),
                            listadoCategorias: categoriaService.listar(),
                            plato: plato
                    ])
            return
        }

        // Intentamos crear el plato
        platoService.actualizar(plato)

        // Redirigimos y mostramos mensaje correcto
        flash.message = "default.plato.actualizado.message"
        redirect(controller: "admin", action: "platos")
    }
}

/**
 * Clase command para el Filtro de platos.
 */
class FiltroPlatos {
    List<Alergeno> alergenos = []
    List<Categoria> categorias = Categoria.findAll()
    Float precioMin = 0
    Float precioMax = Plato.executeQuery("SELECT MAX(total) FROM Plato")[0] ?: 300
}

/**
 * Clase categoría con lista de platos.
 */
class CategoriaConPlatos extends Categoria {
    List<Plato> platos = []

    CategoriaConPlatos(Categoria c, List<Plato> p = []){
        super(nombre: c.nombre, orden: c.orden, id: c.id)
        this.platos = p
    }
}