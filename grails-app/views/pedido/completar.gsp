<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.nuevoPedido.label"/></title>
    <g:set var="cliente" value="${session?.cliente}"/>
</head>
<body>
<!-- Sección del formulario --->
<section class="p-2 bg-white" style="min-height: 80vh">

    <!-- Hero pedido completado -->
    <div class="d-flex justify-content-center align-items-center">
        <div class="col-8 jumbotron jumbotron-fluid bg-dark">
            <div class="container">
                <h1 class="display-4 text-white font-titulo">
                    <g:message code="default.pedido.completado.titulo.message"/>
                    <i class="fas fa-check"></i>
                </h1>
                <p class="lead text-white">
                    <g:message code="default.pedido.completado.message"/>
                </p>
                <g:link class="btn btn-primary" controller="pedido" action="pedidos"><g:message code="default.button.verPedidos.completar.message"/></g:link>
            </div>
        </div>
    </div>

</section>

<g:applyLayout name="pie" />
</body>
</html>