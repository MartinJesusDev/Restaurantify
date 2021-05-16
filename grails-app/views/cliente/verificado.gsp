<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.registro.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white">
        <!-- Titulo de la página -->
        <div class="col mb-3">
            <h2 class="align-titulo p-3 bg-light font-titulo">
                <g:message code="default.title.cliente.verificacion.label"/>
            </h2>
        </div>

        <!-- Tarjeta estado de la verificación -->
        <div class="jumbotron bg-light" >
            <h3 class=" ${flash.verificado ? "text-success" : "text-danger"}"><g:message code="${flash.message}" /></h3>
        </div>

    </section>

    <g:applyLayout name="pie" />
</body>
</html>