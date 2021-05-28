// Lista de los pedidos con todas su información
let listaPedidos = [
    espera = [],
    preparacion = [],
    reparto = [],
    completados = [],
    cancelados = []
]

// Lista de las cajas de caja estado de pedido donde se imprimira
let listaCajas = [
    espera,
    reparto,
    preparacion,
    completados,
    cancelados
]

// Lista con los sortables para crear la funcionalidad
let listaSortables = [
    espera,
    preparacion,
    reparto,
    completados,
    cancelados
]

/**
 * Carga los al entrar a la página de gestión de pedidos.
 */
async function cargarPedidosInicio() {
    // Cargamos los sortables
    listaCajas[0] = document.getElementById('pedidosEnEspera')
    listaCajas[1] = document.getElementById('pedidosEnPreparacion')
    listaCajas[2] = document.getElementById('pedidosEnReparto')
    listaCajas[3] = document.getElementById('pedidosCompletar')
    listaCajas[4] = document.getElementById('pedidosCancelar')

    // Creamos los sortables
    listaSortables[0] = Sortable.create(listaCajas[0], {
        group: {
            name: "pedidos"
        },
        animation: 150,
        easing: "cubic-bezier(0.83, 0, 0.17, 1)",
        handle: '.my-handle',
        ghostClass: 'active',
        dragClass: 'active',
        onRemove: evt => {
            let id = parseInt(evt.item.getAttribute("data-id"))
            cambiarPedidoLista(id, evt.to, evt.from)

        }

    })
    listaSortables[1] = Sortable.create(listaCajas[1], {
        group: {
            name: "pedidos"
        },
        animation: 150,
        easing: "cubic-bezier(0.83, 0, 0.17, 1)",
        handle: '.my-handle',
        ghostClass: 'active',
        dragClass: 'active',
        onRemove: evt => {
            let id = parseInt(evt.item.getAttribute("data-id"))
            cambiarPedidoLista(id, evt.to, evt.from)

        }

    })
    listaSortables[2] = Sortable.create(listaCajas[2], {
        group: {
            name: "pedidos"
        },
        animation: 150,
        easing: "cubic-bezier(0.83, 0, 0.17, 1)",
        handle: '.my-handle',
        ghostClass: 'active',
        dragClass: 'active',
        onRemove: evt => {
            let id = parseInt(evt.item.getAttribute("data-id"))
            cambiarPedidoLista(id, evt.to, evt.from)
        }

    })
    listaSortables[3] = Sortable.create(listaCajas[3], {
        group: {
            name: "pedidos"
        },
        animation: 150,
        easing: "cubic-bezier(0.83, 0, 0.17, 1)",
        handle: '.my-handle',
        ghostClass: 'active',
        dragClass: 'active',
        onAdd: async evt => {
            // Obtenemos el id para realizar operacione varias
            let id = parseInt(evt.item.getAttribute("data-id"))
            await cambiarEstado(id, 3)
            evt.item.remove()
        },
    })
    listaSortables[4] = Sortable.create(listaCajas[4], {
        group: {
            name: "pedidos"
        },
        animation: 150,
        easing: "cubic-bezier(0.83, 0, 0.17, 1)",
        handle: '.my-handle',
        ghostClass: 'active',
        dragClass: 'active',
        onAdd: async evt => {
            // Obtenemos el id para realizar operacione varias
            let id = parseInt(evt.item.getAttribute("data-id"))

            // Si acepta, cancelamos el pedido, si no lo movemos a la lista anterior
            await cambiarEstado(id, -1)
            evt.item.remove()
        },
    })

    // Obtenemos las listas de pedidos
    listaPedidos[0] = await obtenerPedidos(0)
    imprimirListaPedidos(listaPedidos[0], listaCajas[0])

    // Imprimimos pedidos en preparación
    listaPedidos[1] = await obtenerPedidos(1)
    imprimirListaPedidos(listaPedidos[1], listaCajas[1])

    // Imprimimos pedidos en reparto
    listaPedidos[2] = await obtenerPedidos(2)
    imprimirListaPedidos(listaPedidos[2], listaCajas[2])

    // inicia un intervalo para comprobar nuevos pedidos cada 5 segundos
    let intervalo = setInterval(async() => {
        await comprobarPedidos(listaPedidos[0], 0, listaCajas[0])
    }, 5000)
}


/**
 * Obtiene una lista de los pedidos.
 * @param estado el estado de los pedidos a obtener.
 * @returns {Array}
 */
async function obtenerPedidos(estado = "") {
    let resultado = []
    resultado = await $.ajax({
        url: `/pedidos/lista/${estado}`,
        type: "GET",
        contentType: "application/json",
    })

    return resultado
}

/**
 *  Cambia el estado del pedido seleccionado.
 * @param {Number} idPedido
 * @param {Number} estado
 */
async function cambiarEstado(idPedido, estado) {
    let datos = JSON.stringify({
        id: idPedido,
        estado: estado,
    })

    try {
         let respuesta = await fetch("/pedidos/estado", {
            method: "PUT",
            body: datos,
            headers: {
                'Content-Type': 'application/json'
            }
        })

        if (!respuesta.ok) {
            await alertUtils("Error al actulizar el pedido, recarge la página", "danger", "Error")
        }

    } catch (e) {

    }
}

/**
 * Quita un pedido de la lista.
 * @param id {Number}
 * @param to {Element}
 * @param from {Element}
 */
function cambiarPedidoLista(id, to, from){
    let pd

    for (let i = 0; i < listaCajas.length; i++) {
        if(from.isSameNode(listaCajas[i])){
            pd = listaPedidos[i].splice(
                listaPedidos[i].findIndex(pl => pl.id === id),1)[0]
            break
        }
    }

    // Comprobamos a donde va dirigido y lo cambiamos en base de datos
    let estados = [0, 1, 2, 3, -1]
    for (let i = 0; i < listaCajas.length; i++) {
        if(to.isSameNode(listaCajas[i])){
            pd.estado = estados[i]
            cambiarEstado(pd.id, pd.estado)
            listaPedidos[i].push(pd)
            break
        }
    }
}

/**
 * Imprime los pedidos.
 * @param pedidos {Array}
 * @param cajaListaPedidos {Element}
 */
function imprimirListaPedidos(pedidos, cajaListaPedidos) {
    // Recorremos los pedidos
    for (const pedido of pedidos) {
        imprimirPedido(pedido, cajaListaPedidos)
    }
}

/**
 * Imprime un pedido en la lista.
 * Data la caja deseada.
 * @param pedido {Object}
 * @param caja {Element}
 */
function imprimirPedido(pedido, caja) {
    // Recorremos los detalles del pedido
    let listaDetalles = ''
    for (const dp of pedido.detalles) {
        listaDetalles += `<li>${dp.nombre} x ${dp.unidades}</li>`
    }

    // Creamos plantillas con los datos
    let plantilla = `
        <div class="list-group-item p-0 mb-1" data-id="${pedido.id}">
            <div class="d-flex card-header w-auto bg-dark text-white justify-content-between align-items-center my-handle">
                <h5 class=" mb-0"><i class="fas fa-grip-lines mr-2"></i>#${pedido.id} · ${pedido.clienteNombre}</h5>
                <button class="btn btn-primary" data-toggle="collapse" data-target="#collapse-${pedido.id}" role="button" aria-expanded="false" aria-controls="collapseCard">
                    <i class="fas fa-chevron-down"></i>
                </button>
            </div>
            <div class="collapse" id="collapse-${pedido.id}">
                <div class="card-body">
                    <h6 >${pedido.direccion}</h6>
                    <hr>
                    <ul class="list-unstyled">
                        ${listaDetalles}
                    </ul>
                <h5>Total: ${pedido.total}€</h5>
                </div>
            </div>
        </div>`

    // Agregamos la plantilla a la caja
    caja.insertAdjacentHTML('beforeend', plantilla)
}

/**
 * Comprueba los pedidos de la base de datos, por si se ha cancelado, o han añadido nuvos.
 * Y añade los nuevos a la lista.
 * @param listaLocal {Array}
 * @param estado {Number}
 * @param cajaLista {Element}
 */
async function comprobarPedidos(listaLocal, estado, cajaLista){
    // Obtenemos los pedidosEnEspera nuevos
    let listaPedidosObtenidos = await obtenerPedidos(estado)

    // Comprobamos si hay algun pedido nuevo
    for (const pn of listaPedidosObtenidos) {
        // Si un pedido de espera no esta en local, se agregara como nuevo
        let nuevoEncontrado = !listaLocal.some(pl => pl.id === pn.id)
        if(nuevoEncontrado){
            imprimirPedido(pn, cajaLista)
            listaLocal.push(pn)
        }
    }

    // Comprobamos si hay algun pedido borrado
    for (let i = 0; i < listaLocal.length; i++) {
        let pl = listaLocal[i]
        // Si un pedido de espera no esta en local, se agregara como nuevo
        let pedidoBorrado = !listaPedidosObtenidos.some(pn => pn.id === pl.id)
        if(pedidoBorrado){
            $(`[data-id="${pl.id}"]`).remove()
            listaLocal.splice(listaLocal.findIndex(pd => pd.id === pl.id), 1)
            i--
        }
    }

}


/**
 * Obtiene las ventas del cliente mediante filtro.
 */
async function filtrarPedidosCliente(offset = 0) {
    // Obtenemos los datos del filtro y páginación
    let fechaInicio = document.getElementById('fechaInicio').value
    let fechaFin = document.getElementById('fechaFin').value
    let estado = document.getElementById('estado').value


    // Obtenemos los pedidos mediante el filtro
    let datos = JSON.stringify({
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
        estado: estado,
        offset: offset
    })

     // Obtenemos los datos
    let resultado = await obtenerPedidosCliente(datos)

    // Imprimimimos la páginacion
    let total = resultado.paginas
    imprimirPedidosCliente(resultado.pedidos)
    imprimirPaginacion('#cajaPaginacion', "filtrarPedidosCliente", total, offset )
}

/**
 * Envia una petición con los filtros.
 * @param datos {String}
 */
async function obtenerPedidosCliente(datos) {
    try {
        // Enviamos la petición
        let peticion = await fetch("/pedidos/cliente",{
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
 *
 * @param pedidos {Array}
 */
function imprimirPedidosCliente(pedidos) {
    // Obtenemos la caja
    let cajaPedidosCliente = document.getElementById('cajaPedidosCliente')

    // Recorremos los pedidos e imprimimos
    let plantilla = ''
    pedidos.forEach((pedido, i) => {
        // Recorremos los detalles del pedido
        let detalles = ''
        pedido.detalles.forEach(dp =>{
            // Total del plato
            let total = dp.total
            total = Math.round(total * 100) / 100

            // Agregamos a la lista detalles
            detalles += `
                <li class="border-bottom pl-0 py-2 mt-1">${dp.nombre} - ${dp.unidades} x  ${total}€</li>
            `
        })

        // Obtenemos la fecha del pedido en un formato comodo
        let fechaJS = new Date(pedido.fecha)
        let fecha = `${fechaJS.getDate()}/${fechaJS.getMonth()+1}/${fechaJS.getFullYear()}`

        // Creamos un badge con el estado del pedido y si esta en espera añadimos botón con la opción de cancelar
        let pEstado = ''
        let btnCancelar = ''
        switch (pedido.estado) {
            case -1:
                pEstado = '<span class="badge badge-danger">Cancelado<i class="fas fa-times ml-2"></i></span>'
                break
            case 0:
                pEstado = '<span class="badge badge-secondary">En espera<i class="fas fa-clock ml-2"></i></span>'
                btnCancelar = `<a class="btn btn-danger" href="/pedido/cancelar/${pedido.id}" 
                    onclick="return confirm('¿Seguro que desea cancelar el pedido?')">Cancelar</a>`
                break
            case 1:
                pEstado = '<span class="badge badge-info">En preparación<i class="fas fa-hamburger ml-2"></i></span>'
                break
            case 2:
                pEstado = '<span class="badge badge-warning">En reparto<i class="fas fa-truck ml-2"></i></span>'
                break
            case 3:
                pEstado = '<span class="badge badge-primary">Completado<i class="fas fa-check ml-2"></i></span>'
                break
        }

        // Comprobamos si tiene fecha de entrega
        let fechaEntrega = pedido.fechaEntrega
        let tiempoEntrega
        if(fechaEntrega !== null){
            fechaEntrega = new Date(fechaEntrega)
        } else {
            fechaEntrega = new Date()
        }
        var diffMs = (fechaEntrega - fechaJS); // milliseconds between now & Christmas
        var diffDays = Math.floor(diffMs / 86400000); // days
        var diffHrs = Math.floor((diffMs % 86400000) / 3600000); // hours
        var diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000); // minutes
        tiempoEntrega = `${diffHrs}h ${diffMins}min`


        plantilla += `
        <div id="accordion${i}">
            <div class="card">
                <div class="card-header bg-dark" id="heading${i}">
                    <h5 class="mb-0">
                        <button class="btn btn-primary text-white mr-2" data-toggle="collapse" data-target="#collapse${i}"
                                aria-expanded="true" aria-controls="collapse${i}">
                                <i class="fas fa-chevron-down"></i>
                        </button>
                        
                        <span class="d-inline-flex flex-wrap text-white">
                            <span><span class="d-sm-inline-block d-none ">Pedido:</span> ${fecha}</span>
                            <span class="ml-2">${pEstado}</span>
                        </span>
                    </h5>
                </div>

                <div id="collapse${i}" class="collapse ${i === 0 ? 'show' : ''}" aria-labelledby="heading${i}" data-parent="#accordion${i}">
                    <!-- Lista de platos -->
                    <div class="card-body">
                        <h3>Información del pedido</h3>
                        <ul class="list-unstyled mb-4">
                            <li><b>Dirección entrega: </b>${pedido.direccion}</li>
                            <li><b>Método pago:</b> Paypal</li>
                            <li><b>Tiempo transcurrido:</b> ${tiempoEntrega}</li>
                        </ul>
                    
                        <h4>Lista de platos</h4>
                        <ul class="list-unstyled pl-0 mb-4 col-md-4">${detalles}</ul>
                        <div>
                            <p class="mb-0"><b>Total platos:</b> ${pedido.total - pedido.gastosEnvio}€</p>
                            <p class="mb-0"><b>Gastos de envio:</b> ${pedido.gastosEnvio}€</p>
                            <h4 class="mb-3"><b>Total: ${pedido.total}€</b></h4>
                        </div>
                        <div>
                            <a class="btn btn-primary" href="/cesta/nuevo/${pedido.id}">Volver a pedir</a>
                            ${btnCancelar}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        `
    })

    cajaPedidosCliente.innerHTML = plantilla
}