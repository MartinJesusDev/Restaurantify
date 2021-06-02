import com.restaurantify.Cliente

class SeguridadInterceptor {

    /**
     * Intercepta las peticiones excepto las indicadas.
     */
    SeguridadInterceptor() {
        matchAll()
        .except(controller: "cliente", action: "login")
        .except(controller: "cliente", action: "registro")
        .except(controller: "cliente", action: "verificar")
        .except(controller: "cliente", action: "contacto")
        .except(controller: "cliente", action: "restablecer")
        .except(controller: "cliente", action: "resetPassword")
        .except(controller: "plato", action: "lista" )
        .except(controller: "plato", action: "show")
        .except(uri: "/")
    }

    /**
     *
     * @return
     */
    boolean before() {
        // Comprueba si no ha iniciado sesión
        if(!session.cliente) {
            redirect(controller: "cliente", action: "login")
            return false
        } else {
            Cliente c = Cliente.get(session?.cliente?.id)
            if(c.bloqueado) {
                session.invalidate()
                redirect uri: "/"
            }
        }

        return true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
