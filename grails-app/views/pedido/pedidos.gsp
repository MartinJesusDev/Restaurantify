<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.gestionPedidos.label" /></title>
</head>
<body>
<!-- Contenedor datos genericos --->
<section class="p-2 bg-white" style="min-height: 80vh;">

    <!-- Listas de pedidos agrupados por secciones -->
    <article class="row px-3 mt-2">
        <div class="col-3">
            <h2 class="card-header bg-dark text-white"><i class="fas fa-clock mr-2"></i>En espera</h2>
            <div class="list-group border p-2 overflow-auto" id="pedidosEnEspera" style="height: 80vh; ">
            </div>
        </div>
        <div class="col-3">
            <h2 class="card-header bg-dark text-white"><i class="fas fa-hamburger mr-2"></i>En preparación</h2>
            <div class="list-group border p-2 overflow-auto" id="pedidosEnPreparacion" style="height: 80vh; ">
            </div>
        </div>
        <div class="col-3">
            <h2 class="card-header bg-dark text-white"><i class="fas fa-truck mr-2"></i>En reparto</h2>
            <div class="list-group border p-2 overflow-auto" id="pedidosEnReparto" style="height: 80vh; ">
            </div>
        </div>
        <div class="col-3 d-flex flex-column justify-content-between" style="height: 80vh;">
            <div class="row h-50">
                <div class="col">
                    <h2 class="card-header bg-dark text-white"><i class="fas fa-check mr-2"></i>Completar</h2>
                    <div class="list-group border p-2 h-100 bg-primary" id="pedidosCompletar"></div>
                </div>
            </div>

            <div class="row h-25">
                <div class="col">
                    <h2 class="card-header bg-dark text-white"><i class="fas fa-times mr-2"></i>Cancelar</h2>
                    <div class="list-group border p-2 h-100 bg-danger" id="pedidosCancelar"></div>
                </div>
            </div>
        </div>
    </article>


</section>

<g:applyLayout name="pie" />
<!-- Cargamos libreria de sortable y de pedidos -->
<asset:javascript src="Sortable.min.js" />
<asset:javascript src="pedidos.js" />

<!-- Carga la lista de pedidos al inicio -->
<script>cargarPedidosInicio();</script>
</body>
</html>