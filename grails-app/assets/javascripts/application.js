// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery.min
//= require popper.min
//= require bootstrap.min
//= require select2.min
//= require_self


/**
 * Función que imprime el resultado de operaciones en un div#resultado
 * @param {array} respuesta
 * @param {Element|null} elemento indica donde imprimir el resultado
 * @param {boolean} autoHide indica si se debe esconder el resultado
 * @param {number} ms tiempo en ms en los que ocultara la caja resultado
 */
function imprimirResultado(respuesta, elemento = null, autoHide = false, ms = 3000) {
    // Obtenemos la el div padre
    let divResultado = null;

    // Si es null intentamos coger un div#resultado por defecto
    if (elemento == null) {
        divResultado = document.querySelector('div#resultado');
    } else {
        divResultado = document.querySelector(elemento);
    }

    // Guardamos los datos de la respuesta
    let mensaje = respuesta.message;
    let error = respuesta.error;
    let plantilla = `
      <div class="alert ${
        error ? 'alert-danger' : 'alert-success'
    } alert-dismissible fade show" role="alert">
        <strong>${error ? '¡Error!' : '¡Éxito!'}</strong> ${mensaje}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    `;

    // Añadimos la plantilla a el div mensaje
    divResultado.innerHTML = plantilla;

    // Muestra el div caja finalmente
    divResultado.classList.remove('d-none');

    // Comprueba si se debe auto ocular
    if(autoHide == true){
        setTimeout(() => divResultado.classList.add('d-none'), ms);
    }
}

/**
 * Imprime una alerta personalizada.
 * @param {String} mensaje
 * @param {String} tipo
 * @param {String} titulo
 * @param {String} callback
 */
function  alertUtils(mensaje, tipo= "primary", titulo = null, callback = null) {
    if(!titulo) {
        switch (tipo) {
            case "danger":
                titulo = "Error"
                break
            case "warning":
                titulo = "Atención"
                break
            default:
                titulo = "Información"
        }
    }


    // Comprobamos si esta pasando una función de callback y la agregamos al btn confirmar
    let modalBtn = ''
    if(callback) {
        modalBtn = `
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-${tipo}" onclick="${callback}">Confirmar</button>
            </div>
        `
    }

    let plantilla = `
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header bg-${tipo} text-white">
                <h4 class="modal-title" id="tituloAlerta">${titulo}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <h5>${mensaje}</h5>
              </div>
                ${modalBtn}
            </div>
          </div>`

    // Obtenemos la caja y ponemos la alerta
    let modal = $('#alertaModal')
    modal.html(plantilla)
    modal.modal('show')
}

/**
 * Imprime la páginación.
 * @param {String} idCajaPaginacion
 * @param {String} funcion
 * @param {Number} total
 * @param {Number} paginaActual
 */
function imprimirPaginacion(idCajaPaginacion, funcion, total, paginaActual = 0){
    // Obtenemos la caja donde se va a imprimir
    let cajaPaginacion = document.querySelector(idCajaPaginacion);

    // Creamos un botón por pagina
    let plantilla = '';

    // Comprobamos si el total paginas no es 0
    if(total !== 0) {
        // Añadimos botón anterior
        plantilla += `
    <li class="page-item ${(paginaActual === 0) ? 'disabled': ''}">
    <a class="page-link" aria-label="Previous" onclick="${funcion}(${paginaActual -1})">
        <span>&laquo;</span>
    </a>
    </li>`;

        // Recorremos la lista botones
        for (let i = 0; i < total; i++) {
            plantilla += `
            <li class="page-item ${paginaActual === i ? 'active disabled': ''}">
            <a class="page-link" aria-label="Previous" onclick="${funcion}(${i})">${i+1}</a>
            </li>
            `
        }

        // Añadimos botón final
        plantilla += `
          <li class="page-item ${(paginaActual === total -1) ? 'disabled': ''}">
            <a class="page-link" aria-label="Next" onclick="${funcion}(${parseInt(paginaActual) + 1})">
                <span>&raquo;</span>
            </a>
          </li>`;
    }

    // Añadimos el fragmento a la caja paginacion
    cajaPaginacion.innerHTML = plantilla;
}
