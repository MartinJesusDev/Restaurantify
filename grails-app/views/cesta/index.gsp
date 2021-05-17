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
<section class="p-2 bg-white" style="min-height: 80vh">
    <!-- Titulo de la página -->
    <div class="card mx-4">
        <h3 class="card-header bg-dark text-white font-titulo">
            <g:message code="default.title.cesta.label"/>
        </h3>
        <div class="card-body">
            <div class="d-none" id="cestaCompra"></div>
            <div class="d-none" id="cestaVacia">
                <h3><g:message code="default.cesta.vacia.message" /></h3>
            </div>
        </div>
    </div>

        <!-- Carrito de la compra -->
        <div class="col px-lg-4 pt-2">

        </div>

        <!-- Información -->
        <div class="col p-4 d-none" id="cajaResumenPedido">
            <!-- Dirección de envio -->
            <div class="card mb-4">
                <h4 class="card-header bg-dark text-white font-titulo"><g:message code="default.input.cesta.infoEnvio.label"/></h4>
                <div class="card-body">
                    <p class="mb-0"><b>${cliente?.nombre}, ${cliente?.email}</b></p>
                    <p class="mb-0">${cliente?.calle}</p>
                    <p class="mb-0">${cliente?.localidad}, ${cliente?.provincia}, ${cliente?.cp}</p>
                    <g:link controller="cliente" action="perfil" >
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
                    <g:link class="btn btn-primary" controller="pedido" action="tramite"><g:message code="default.button.pedido.completar.message" /></g:link>
                </div>
            </div>

        </div>
</section>

<g:applyLayout name="pie" />

<!-- Cargamos js para la cesta -->
<asset:javascript src="cesta.js" />
</body>
</html>