<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.mispedidos.label" /></title>
</head>
<body>
<!-- Contenedor datos genericos --->
<section class="p-2 bg-white" style="min-height: 80vh;">

    <!-- Listas de pedidos agrupados por secciones -->
    <article class="row mx-xl-5">
        <div class="col">
            <div class="card text-white bg-dark">
                <h2 class="card-header font-titulo"><g:message code="default.title.mispedidos.label"/> </h2>
            </div>
            <div class="col p-3 mb-3 bg-light border rounded">
            <!-- Formulario de filtros -->
                <h4>Filtro de pedidos</h4>
                <div class="form-row">
                    <div class="form-group  col-md-2 col-6">
                        <label for="fechaInicio">Desde</label>
                        <g:field class="form-control" type="date" name="fechaInicio" placeholder="dd/mm/aaaa" />
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="fechaFin">Hasta</label>
                        <g:field class="form-control" type="date" name="fechaFin" placeholder="dd/mm/aaaa" />
                    </div>
                    <div class="form-group col-md-2">
                        <label for="estado">Estado del pedido</label>
                        <select class="custom-select" id="estado">
                            <option value="">Todos</option>
                            <option value="-1">Cancelado</option>
                            <option value="0">En espera</option>
                            <option value="1">En preparación</option>
                            <option value="2">En reparto</option>
                            <option value="3">Completados</option>
                        </select>
                    </div>
                    <div class="form-group col-1 d-flex align-items-end">
                        <button class="btn btn-primary" onclick="filtrarPedidosCliente()">Filtrar</button>
                    </div>
                </div>
            </div>
            <div class="col p-0">
                <div id="cajaPedidosCliente"></div>
                <ul class="mt-2 pagination justify-content-center" id="cajaPaginacion"></ul>
            </div>
        </div>
    </article>

</section>

<g:applyLayout name="pie" />
<!-- Cargamos libreria de sortable y de pedidos -->
<asset:javascript src="pedidos.js" />
<script>filtrarPedidosCliente()</script>
</body>
</html>