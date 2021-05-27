<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.alergenos.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="px-0 mt-2 mx-xl-5 bg-light border rounded">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.ventas.label"/>
        </h2>
    </div>


    <!-- Listado de alergenos -->
    <div class="col">
        <table class="col-md-8 table table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Fecha</th>
                    <th>Total platos</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody id="tablaVentas"></tbody>
        </table>
    </div>
</section>

<g:applyLayout name="pie" />

<!-- Cargamos script para las ventas -->
<asset:javascript src="ventas.js" />
</body>
</html>
