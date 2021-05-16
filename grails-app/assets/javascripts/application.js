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
    let plantilla = ""

    if(error) {
        plantilla = `
            <div class="alert d-f ml-0 errors rounded" role="alert"><li>${mensaje}</li></div>`
    } else {
        plantilla = `<div class="alert ml-0 message rounded" role="status">${mensaje}</div>`
    }

    // Añadimos la plantilla a el div mensaje
    divResultado.innerHTML = plantilla;

    // Muestra el div caja finalmente
    divResultado.classList.remove('d-none');

    // Comprueba si se debe auto ocular
    if(autoHide == true){
        setTimeout(() => divResultado.classList.add('d-none'), ms);
    }
}