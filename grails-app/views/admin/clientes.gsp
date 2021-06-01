<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="px-0 mt-2 mx-xl-5 mb-4 bg-light border rounded">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.cliente.label"/>
        </h2>
        <div class="col px-0 py-3 bg-light">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="busqueda"><g:message code="default.input.clientes.busquedaMultiple.label"/></label>
                    <g:field class="form-control" type="text" name="busqueda" placeholder="DNI, nombre, apellidos, email.." />
                </div>
                <div class="form-group  col-md-2 col-6">
                    <label for="fechaInicio"><g:message code="default.input.clientes.desde.label"/></label>
                    <g:field class="form-control" type="date" name="fechaInicio" placeholder="dd/mm/aaaa" />
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="fechaFin"><g:message code="default.input.clientes.hasta.label"/></label>
                    <g:field class="form-control" type="date" name="fechaFin" placeholder="dd/mm/aaaa" />
                </div>
                <div class="form-group  col-md-2 col-6">
                    <label for="sort"><g:message code="default.input.clientes.ordenar.label"/></label>
                    <select class="custom-select" name="sort" id="sort">
                        <option value="fechaDeAlta"><g:message code="default.input.clientes.ordenar.fecha.label"/></option>
                        <option value="dni"><g:message code="default.input.dni.label"/></option>
                        <option value="nombre"><g:message code="default.input.name.label"/></option>
                        <option value="rol"><g:message code="default.input.rol.label"/></option>
                        <option value="verificado"><g:message code="default.input.verificado.label"/></option>
                        <option value="bloqueado"><g:message code="default.input.bloqueado.label"/></option>
                    </select>
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="order"><g:message code="default.input.clientes.ascdsc.label"/></label>
                    <select class="custom-select" name="order" id="order">
                        <option value="DESC"><g:message code="default.input.clientes.ascdsc.descendente.label"/></option>
                        <option value="ASC"><g:message code="default.input.clientes.ascdsc.ascendente.label"/></option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col">
                    <button class="btn btn-primary" onclick="filtrarClientes()"><g:message code="default.buttom.aplicarBusqueda.label"/></button>
                </div>
            </div>
        </div>
    </div>


    <!-- Listado de alergenos -->
    <div class="col">
        <!-- Div que muestra resultado -->
        <div id="resultado"></div>
        <table class="col table table-hover table-responsive-md bg-white border rounded">
            <thead class="thead-dark">
            <tr>
                <th>DNI</th>
                <th>Nombre apellidos</th>
                <th>Email</th>
                <th>Fecha alta</th>
                <th>Rol</th>
                <th>Verificado</th>
                <th>Bloqueado</th>
                <th>Opciones</th>
            </tr>
            </thead>
            <tbody id="tablaClientes"></tbody>
        </table>
        <ul class="mt-2 pagination justify-content-center" id="cajaPaginacion"></ul>
    </div>
</section>

<g:applyLayout name="pie" />

<!-- Cargamos script para las clientes -->
<asset:javascript src="clientes.js" />
<script>filtrarClientes()</script>
</body>
</html>
