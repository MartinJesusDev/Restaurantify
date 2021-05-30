<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.registro.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="row p-2 justify-content-center bg-white mx-xl-5" style="height: 80vh;">
        <div class="col-lg-8 p-0 col">
            <!-- Titulo de la página -->
            <div class="col p-3 mb-0 border bg-dark text-white">
                <h2 class="align-titulo font-titulo">
                    <g:message code="default.title.cliente.verificacion.label"/>
                </h2>
            </div>

            <!-- Tarjeta estado de la verificación -->
            <div class="jumbotron bg-light border rounded" >
                <h3 class=" ${flash.verificado ? "text-success" : "text-danger"}"><g:message code="${flash.message}" /></h3>
            </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>