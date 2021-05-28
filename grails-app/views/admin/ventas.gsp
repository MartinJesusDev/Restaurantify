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
        <div class="col px-0 py-3 bg-light">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="cliente">Cliente</label>
                    <g:field class="form-control" type="text" name="cliente" />
                </div>
                <div class="form-group  col-md-2 col-6">
                    <label for="fechaInicio">Desde</label>
                    <g:field class="form-control" type="date" name="fechaInicio" placeholder="dd/mm/aaaa" value="${(new Date() - 31).format("yyyy-MM-dd")}" />
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="fechaFin">Hasta</label>
                    <g:field class="form-control" type="date" name="fechaFin" placeholder="dd/mm/aaaa" value="${(new Date()).format("yyyy-MM-dd")}" />
                </div>
                <div class="form-group  col-md-2 col-6">
                    <label for="sort">Ordenar</label>
                    <select class="custom-select" name="sort" id="sort">
                        <option value="fecha">Fecha</option>
                        <option value="total">total</option>
                        <option value="id">ID</option>
                    </select>
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="order">ASC/DESC</label>
                    <select class="custom-select" name="order" id="order">
                        <option value="DESC">Descendente</option>
                        <option value="ASC">Ascendente</option>
                    </select>
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="totalMin">Mínimo</label>
                    <g:field class="form-control" step="0.01" min="0" type="number" name="totalMin" />
                </div>
                <div class="form-group col-md-2 col-6">
                    <label for="totalMax">Máximo</label>
                    <g:field class="form-control" step="0.01" min="0" type="number" name="totalMax" />
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col">
                    <button class="btn btn-primary" onclick="filtrarVentas()">Aplicar busqueda</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Listado de alergenos -->
    <div class="col">
        <table class="col table table-hover table-responsive-md bg-white border rounded">
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
        <ul class="mt-2 pagination justify-content-center" id="cajaPaginacion"></ul>
    </div>
</section>

<g:applyLayout name="pie" />

<!-- Cargamos script para las ventas -->
<asset:javascript src="ventas.js" />
<script>filtrarVentas()</script>
</body>
</html>
