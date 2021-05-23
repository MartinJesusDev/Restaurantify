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
 * @return {Boolean}
 */
async function cambiarEstado(idPedido, estado) {
    let datos = JSON.stringify({
        id: idPedido,
        estado: estado,
    })

     return fetch("/pedidos/estado", {
        method: "PUT",
        body: datos,
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(respuesta => respuesta.ok )
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