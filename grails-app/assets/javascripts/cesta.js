"use strict"

/**
 * Cesta de la compra del usuario.
 * @type {*[]}
 */
let cesta = [];

/**
 * Realiza una petición para obtener datos de la cesta al cargar el DOM.
 */
async function cargarCesta() {
    obtenerCesta().then((data) => {
        imprimirCesta()
        imprimirTotalPedido()
    })
}

/**
 * Agrega las unidades al carrito.
 * @param idCliente {Number}
 * @param idPlato {Number}
 * @param unidades {Number}
 */
function agregar(idCliente, idPlato, unidades) {

    // Comprobamos si inicio sesión
    if (idCliente === -1) {
        window.location.replace("cliente/login")
        return
    }

    // Realizamos la petición
    let datos = JSON.stringify({
        "cliente": idCliente,
        "plato": idPlato,
        "unidades": unidades
    })

    $.ajax({
        url: "/cesta/agregar",
        type: "POST",
        contentType: "application/json",
        data: datos,
        complete: function (xhr, status) {
            let error = status !== "success"
            let data = {
                message: xhr.responseJSON.message,
                error: error
            }
            imprimirResultado(data)
        }
    })
}


/**
 * Obtiene los datos de la cesta.
 * Llama a la función para imprimir la cesta con los datos.
 */
async function obtenerCesta() {
    let result = []

    try {
        result =  await $.ajax({
            url: "/cesta",
            type: "GET",
            contentType: "application/json",
            complete: function (xhr, status) {
                cesta = xhr.responseJSON
            }
        })
    } catch (e) {
        console.log("Error cargando la cesta")
    }

    return result
}


/**
 * Imprime la página carrito.
 */
async function imprimirCesta() {
    // OBtenemos la caja de la cesta
    let cajaCesta = $('#cestaCompra')
    let cestaVacia = $('#cestaVacia')

    // Comprobamos si hubo error para mostrarlo o mostrar los platos
    let plantilla = '';

    // Comprobamos si la cesta no esta vacia
    if (cesta !== undefined &&
        cesta != null &&
        cesta.length > 0
    ) {
        // Recorremos los cesta
        let totalArtitulos = 0;
        let totalPedido = 0;
        for (const c of cesta) {
            let plato = c.plato
            c.unidades = parseInt(c.unidades);

            // Creamos desplegable para seleccionar unidades
            let opcionesSelect = '';
            // Creamos una opción por cada unidad
            for (let i = 1; i <= 10; i++) {
                opcionesSelect += `<option value="${i}" ${(i === c.unidades) ? 'selected' : ''}>${i}</option>`;
            }
            let desplegableUnidades = `<select class="custom-select-sm w-auto" id="cantidadUnidades" onchange="actualizarCesta(${c.id}, this.value)">${opcionesSelect}</select>`;

            totalPedido += (plato.total * c.unidades);
            totalPedido = parseFloat(totalPedido.toFixed(2));

            // Guardamos la plantilla
            plantilla += `
              <div id="itemCesta${c.id}" class="d-flex align-items-center border-bottom py-3 mb-1">                 
                <img alt="${plato.imagen}" class="mr-3 d-md-block d-none" src="/assets/platos/${plato.imagen}" width="100px" height="75px">
                <div class="d-md-block d-flex align-items-center justify-content-between w-100">
                    <div class="mb-md-2 mr-3">
                        <a class="btn-link d-inline-block" href="/plato/show/${plato.id}" style="font-size: 1.25em" >${plato.nombre}<span class="badge badge-primary ml-2">${plato.total}€</span></a>
                    </div>
                    <div class="btn-group btn-group-sm">
                        ${desplegableUnidades}
                        <button class="btn btn-danger" style="height: max-content;" onclick="eliminarPlatoCesta(${c.id});">
                            <i class="fa fa-times"></i>
                        </button>
                    </div>
                </div>
              </div>
            `;

            totalArtitulos += parseInt(c.unidades);
        }

        plantilla += `
            <div class="py-3"><h5>Total platos: <span id="totalPlatosSup"></span>€</h5></div>
        `


        // Imprimimos los nuevos datos en el DOM
        cajaCesta.html(plantilla);
        cajaCesta.removeClass(['d-none'])
        cestaVacia.addClass(['d-none'])
    } else {
        cestaVacia.removeClass(['d-none'])
        cajaCesta.addClass(['d-none'])
    }
}


/**
 * Muestra la caja con la información del total del pedido.
 * @returns {{total: number, totalPedido: number, gastosEnvio: number}}
 */
function calcularTotal() {
        // Datos del total del pedido
        let totalPedido = 0;
        let gastosEnvio = 3;

        // Recorremos la cesta y calculamos el total de pedido
        for (const c of cesta) {
            let plato = c.plato
            c.unidades = parseInt(c.unidades);
            totalPedido += (plato.total * c.unidades);
            totalPedido =  Math.round(totalPedido * 100) / 100
        }
        let total = Math.round((totalPedido + gastosEnvio) * 100) / 100

    return {
            totalPedido: totalPedido,
            gastosEnvio: gastosEnvio,
            total: total
    }
}

/**
 * Imprime el total del pedido en la caja.
 */
function imprimirTotalPedido() {
    if(cesta.length > 0) {
        // Calcula los datos
        let datos = calcularTotal()

        // Imprime los valores
        $('#cajaResumenPedido').removeClass(['d-none'])
        $('#gastosEnvio').text(datos.gastosEnvio)
        $('#totalPlatos').text(datos.totalPedido)
        $('#totalPlatosSup').text(datos.totalPedido)
        $('#totalPedido').text(datos.total)
    } else {
        $('#cajaResumenPedido').addClass(['d-none'])
    }
}

/**
 * Envia una petición para cambiar las unidades de la cesta.
 */
function actualizarCesta(idCesta, unidades) {
    // Datos a enviar
    let datos = JSON.stringify({
        id: idCesta,
        unidades: unidades
    })

    $.ajax({
        url: "/cesta/modificar",
        type: "PUT",
        data: datos,
        contentType: "application/json",
        complete: function (xhr, status) {
            // Recarga la cesta para calcular los nuevos datos
            cesta.forEach((c)=>{
                if(c.id === idCesta ){
                    c.unidades = unidades
                }
            })
            // Refresca el total del pedido.
            imprimirTotalPedido()
        }
    })
}

/**
 * Elimina un plato de la cesta dado el id.
 * Elimina de la lista ese plato.
 * @param idCesta
 */
function eliminarPlatoCesta(idCesta) {
    $.ajax({
        url: `/cesta/${idCesta}`,
        type: "DELETE",
        contentType: "application/json",
        complete: function (xhr, status) {
            obtenerCesta().then(()=>{
                document.querySelector(`#itemCesta${idCesta}`).remove()
                imprimirTotalPedido()
                if (cesta.length === 0) {imprimirCesta()}
            })
        }
    })
}