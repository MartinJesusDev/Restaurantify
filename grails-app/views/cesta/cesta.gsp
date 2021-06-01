<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cesta.label"/></title>
    <g:set var="cliente" value="${session?.cliente}"/>
</head>
<body>
<!-- Sección del formulario --->
<section class="p-2 bg-white mx-xl-5" style="min-height: 80vh">
    <!-- Titulo de la página -->
    <div class="card">
        <div id="resultado">
        <!-- Mensaje informativo plato --->
            <g:if test="${flash.message}">
                <div>
                <g:if test="${flash.error}" >
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <g:message code="${flash.message}" />
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </g:if>
                <g:else>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <g:message code="${flash.message}" />
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </g:else>
                </div>
            </g:if>
        </div>
        <h3 class="card-header bg-dark text-white font-titulo">
            <g:message code="default.title.cesta.label"/>
        </h3>
        <div class="card-body pt-0 pb-1">
            <div class="d-none" id="cestaCompra"></div>
            <div class="d-none p-2" id="cestaVacia">
                <h3><g:message code="default.cesta.vacia.message" /></h3>
            </div>
        </div>
    </div>

        <!-- Carrito de la compra -->
        <div class="col px-lg-4 mb-4">

        </div>

        <!-- Información -->
        <div class="col p-0 d-none" id="cajaResumenPedido">
            <!-- Dirección de envio -->
            <div class="card mb-4">
                <h4 class="card-header bg-dark text-white font-titulo"><g:message code="default.input.cesta.infoEnvio.label"/></h4>
                <div class="card-body">
                    <p class="mb-0"><b>${cliente?.nombre}, ${cliente?.email}</b></p>
                    <p class="mb-0">${cliente?.calle}</p>
                    <p class="mb-0">${cliente?.localidad}, ${cliente?.provincia}, ${cliente?.cp}</p>
                    <g:link class="font-weight-bolder" controller="cliente" action="perfil" >
                        <g:message code="default.input.cesta.direccion.cambiar.label" />
                    </g:link>
                </div>
            </div>

            <!-- Metodo de pago -->
            <div class="card mb-4">
                <h4 class="card-header bg-dark text-white font-titulo">Método de pago</h4>
                <div class="card-body">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fab fa-cc-paypal mr-3" style="font-size: 2em;"></i>
                        <input class="mr-2" type="radio" name="pago" id="pago1" value="1" checked>
                        <label for="pago1" class="d-inline-flex align-items-center mb-0">
                            <b>Paypal</b>
                        </label>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fab fa-cc-visa mr-3" style="font-size: 2em;"></i>
                        <input class="mr-2" type="radio" name="pago" id="pago2" value="1">
                        <label for="pago2" class="d-inline-flex align-items-center mb-0">
                            <b>Visa</b>
                        </label>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fab fa-cc-mastercard mr-3" style="font-size: 2em;"></i>
                        <input class="mr-2" type="radio" name="pago" id="pago3" value="1">
                        <label for="pago3" class="d-inline-flex align-items-center mb-0">
                            <b>Mastercard</b>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Total del pedido -->
            <div class="card">
                <h4 class="card-header bg-dark text-white font-titulo"><g:message code="default.input.pedido.totalPedido.label"/></h4>
                <div class="card-body">
                    <ul class="list-unstyled">
                        <li><g:message code="default.input.pedido.gastosEnvio.label"/>: <span id="gastosEnvio"></span>€</li>
                        <li><g:message code="default.input.pedido.totalPlatos.label"/>: <span id="totalPlatos"></span>€</li>
                        <li><h5><g:message code="default.input.pedido.total.label"/>: <span id="totalPedido"></span>€</h5></li>
                    </ul>
                    <button class="btn btn-primary" id="realizarPedido" type="button"><g:message code="default.button.pedido.completar.message" /></button>
                </div>
            </div>

        </div>
</section>

<g:applyLayout name="pie" />

<script>
    (function(){
        let btnPedido = document.getElementById('realizarPedido')
        if(btnPedido) {
            btnPedido.addEventListener('click', () => {
                alertUtils(
                    "${message(code: "default.cesta.confirmar.message")}",
                    "primary",
                    "${message(code: "default.cesta.confirmar.titulo.message")}",
                    "window.location.replace('/pedido/completar')"
                )
            })
        }
    })()
</script>
</body>
</html>