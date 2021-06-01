package com.restaurantify

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        group "/cesta", {
            post "/agregar"(controller: "cesta", action: "agregar")
            put "/modificar"(controller: "cesta", action: "modificar")
            get "/"(controller: "cesta", action: "listar")
            delete "/$id"(controller: "cesta", action: "eliminar")
        }

        group "/pedidos", {
            get "/lista/$estado"(controller:  "pedido", action: "pedidos")
            put "/estado"(controller:  "pedido", action: "modificarEstado")
            post "/cliente"(controller: "pedido", action: "pedidosCliente")
            post "/ventas"(controller: "pedido", action: "ventas")
        }

        group "/clientes", {
            post "/lista"(controller: "cliente", action: "listar")
            put "/adminResetPassword/$email"(controller: "cliente", action: "adminResetPassword")
            put "/blockDesckblock/$id"(controller: "cliente", action: "toggleBloqueoCliente")
        }

        "/"(controller: "inicio", action: "index")
        "500"(controller: "inicio", action: "error")
        "404"(controller: "inicio", action: "notFound")
    }
}
