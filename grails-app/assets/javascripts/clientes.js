/**
 * Obtiene los cliente
 * @param offset
 */
async function filtrarClientes(offset = 0) {

    // Cojemos los valores de los inputs
    let datos = JSON.stringify({
        busqueda: $('#busqueda').val(),
        fechaInicio: $('#fechaInicio').val(),
        fechaFin: $('#fechaFin').val(),
        sort: $('#sort').val(),
        order: $('#order').val(),
        offset: offset
    })


    // Obtenemos las ventas
    let resultado = await obtenerClientes(datos)

    // Imprimimos la tabla con los clientes
    imprimirVentas(resultado.clientes)

    // Imprimimimos la páginacion
    let total = resultado.paginas
    imprimirPaginacion('#cajaPaginacion', "filtrarClientes", total, offset)
}

/**
 * Envia una petición con los filtros para obtener las ventas.
 * @param datos
 */
async function obtenerClientes(datos) {
    try {
        // Enviamos la petición
        let peticion = await fetch("/clientes/lista",{
            method: "POST",
            body: datos,
            headers: {
                "Content-Type": "application/json"
            }
        })

        // Esperamos la respuesta y la retornamos
        return await peticion.json()
    } catch (e) {}
}

/**
 * Envia al servidor una petición con el correo del cliente.
 * Para que el cliente pueda cambiar su contraseña mediante un email.
 * @param {String} email
 */
async function resetPasswordEmail(email) {
    try {
        // Enviamos la petición
        let peticion = await fetch(`/clientes/adminResetPassword/${email}`,{
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            }
        })

        // Esperamos la respuesta
        let respuesta = await peticion.json()
        imprimirResultado(respuesta)
    } catch (e) {}
}

/**
 * Envia un petición al servidor para hacer un toggle bloquear/debloquear de un cliente.
 * @param {Number} id
 */
async function toggleBloqueo(id) {
    try {
        // Enviamos la petición
        let peticion = await fetch(`/clientes/blockDesckblock/${id}`,{
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            }
        })

        // Esperamos la respuesta
        let respuesta = await peticion.json()

        // Comprobamos e imprimimos el nuevo badge segun el estado
        let badge = ''
        if(respuesta.bloqueado) {
            badge = '<span class="p-2 badge badge-success"><i class="fas fa-check"></i></span>'
        } else {
            badge = '<span class="p-2 badge badge-danger"><i class="fas fa-times"></i></span>'
        }
        document.getElementById(`tdBlock${id}`).innerHTML = badge

        // Cambiamos el estado de bloqueado para el id del usuario
        imprimirResultado(respuesta)
    } catch (e) {}
}

/**
 * Imprime los clientes.
 * @param clientes {Array}
 */
function imprimirVentas(clientes) {
    // OBtejemos la tabla clientes
    let tablaClientes = document.getElementById('tablaClientes')

    // Dibujamos la plantilla
    let plantilla = ''
    clientes.forEach((c, i) => {
        // Guardamos la fecha en un formato imprimible
        let fecha = new Date(c.fechaAlta)
        fecha = `${fecha.getDate()}/${fecha.getMonth() + 1 }/${fecha.getFullYear()}`

        // Comprobamos el rol
        let rol = ''
        switch (c.rol) {
            case 0:
                rol = 'Cliente'
                break
            case 1:
                rol = 'Administrador'
                break
            case 2:
                rol = 'Restaurante'
                break
        }

        // Diseños de badge
        let badgeTrue = '<span class="p-2 badge badge-success"><i class="fas fa-check"></i></span>'
        let badgeFalse = '<span class="p-2 badge badge-danger"><i class="fas fa-times"></i></span>'

        // Imprimimos el badge verificado
        let badgeVerificado = c.verificado ? badgeTrue : badgeFalse

        // Imprimimos el badge bloqueado
        let badgeBloqueado = c.bloqueado ? badgeTrue : badgeFalse

        /// Agregamos nueva fila
        plantilla += `
            <tr>
                <td>${c.dni}</td>
                <td>${c.nombreApellidos}</td>
                <td>${c.email}</td>
                <td>${fecha}</td>
                <td>${rol}</td>
                <td class="pl-4">${badgeVerificado}</td>
                <td class="pl-4" id="tdBlock${c.id}">${badgeBloqueado}</td>
                <td>
                   <div class="dropdown">
                      <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownAdminClientes" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Opciones
                      </button>
                      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownAdminClientes">
                        <button class="dropdown-item" onclick="resetPasswordEmail('${c.email}')">Resear contraseña</button>
                        <button class="dropdown-item" onclick="toggleBloqueo('${c.id}')">Bloquear / desbloquear</button> 
                      </div>
                    </div>
                </td>
            </tr>
        `
    })

    // Imprimimos la plantilla de ventas
    tablaClientes.innerHTML = plantilla
}