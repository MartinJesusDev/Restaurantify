<!-- Barra lateral de navegación admin -->
<nav class="nav nav-pills border rounded p-2 bg-dark">

    <g:link controller="admin" action="index" class="nav-link text-white ${actionName == "index" ? "active" : ""}">
        <g:message code="default.button.admin.estadisticas.message" />
    </g:link>

    <g:link controller="admin" action="pedidos" class="nav-link text-white ${request.forwardURI.contains("pedido") ? "active" : ""}">
        <g:message code="default.button.admin.pedidos.message" />
    </g:link>

    <g:link controller="admin" action="platos" class="nav-link text-white ${request.forwardURI.contains("plato") ? "active" : ""}">
        <g:message code="default.button.admin.platos.message" />
    </g:link>

    <g:link controller="admin" action="alergenos" class="nav-link text-white ${request.forwardURI.contains("alergeno") ? "active" : ""}">
        <g:message code="default.button.admin.alergeno.message" />
    </g:link>

    <g:link controller="admin" action="categorias" class="nav-link text-white ${request.forwardURI.contains("categoria") ? "active" : ""}">
        <g:message code="default.button.admin.categorias.message" />
    </g:link>

    <g:link controller="admin" action="ventas" class="nav-link text-white ${request.forwardURI.contains("venta") ? "active" : ""}">
        <g:message code="default.button.admin.ventas.message" />
    </g:link>

    <g:link controller="admin" action="clientes" class="nav-link text-white ${actionName == "clientes" ? "active" : ""}">
        <g:message code="default.button.admin.clientes.message" />
    </g:link>

    <g:link controller="admin" action="websettings" class="nav-link text-white ${actionName == "websettings" ? "active" : ""}">
        <g:message code="default.button.admin.websettings.message" />
    </g:link>
</nav>