/**
 * Obtiene las ventas = pedidos clientes completados.
 * @param offset
 */
async function filtrarVentas(offset = 0) {

    // Cojemos los valores de los inputs
    let datos = JSON.stringify({
        cliente: $('#cliente').val(),
        fechaInicio: $('#fechaInicio').val(),
        fechaFin: $('#fechaFin').val(),
        totalMin: $('#totalMin').val(),
        totalMax: $('#totalMax').val(),
        sort: $('#sort').val(),
        order: $('#order').val(),
        offset: offset
    })


    // Obtenemos las ventas
    let resultado = await obtenerVentas(datos)

    // Imprimimos la tabla con las ventas
    imprimirVentas(resultado.pedidos)

    // Imprimimimos la páginacion
    let total = resultado.paginas
    imprimirPaginacion('#cajaPaginacion', "filtrarVentas", total, offset)
}

/**
 * Envia una petición con los filtros para obtener las ventas.
 * @param datos
 */
async function obtenerVentas(datos) {
    try {
        // Enviamos la petición
        let peticion = await fetch("/pedidos/ventas",{
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
 * Imprime las ventas.
 * @param pedidos {Array}
 */
function imprimirVentas(pedidos) {
    // OBtejemos la tabla ventas
    let tablaVentas = document.getElementById('tablaVentas')

    // Dibujamos la plantilla
    let plantilla = ''
    pedidos.forEach((p, i) => {
        // Guardamos la fecha en un formato imprimible
        let fecha = new Date(p.fecha)
        fecha = `${fecha.getDate()}/${fecha.getMonth() + 1 }/${fecha.getFullYear()}`

        // Sumas el total de platos
        let totalPlatos = 0
        p.detalles.forEach(()=>totalPlatos += 1)

        /// Agregamos nueva fila
        plantilla += `
            <tr>
                <td>${p.id}</td>
                <td>${p.clienteNombre}</td>
                <td>${p.clienteEmail}</td>
                <td>${fecha}</td>
                <td>${totalPlatos}</td>
                <td>${p.total}€</td>
            </tr>
        `
    })

    // Imprimimos la plantilla de ventas
    tablaVentas.innerHTML = plantilla
}