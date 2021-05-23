class SeguridadInterceptor {

    /**
     * Intercepta las peticiones excepto las indicadas.
     */
    SeguridadInterceptor() {
        matchAll()
        .except(controller: "cliente", action: "login")
        .except(controller: "cliente", action: "registro")
        .except(controller: "cliente", action: "verificar")
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
        }

        return true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
