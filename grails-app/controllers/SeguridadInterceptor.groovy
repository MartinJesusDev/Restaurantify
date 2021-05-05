class SeguridadInterceptor {

    /**
     * Intercepta las peticiones excepto las indicadas.
     */
    SeguridadInterceptor() {
        matchAll()
        .except(controller: "cliente", action: "login")
        .except(controller: "cliente", action: "registro")
        .except(controller: "cliente", action: "verificar")
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

        // Comprobamos si accede a la parte de administrador, y no es administrador
        if(controllerName == "admin" && session.cliente.rol != 1){
            redirect(uri: "/")
            return false
        }

        return true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
