<!-- Barra lateral de navegación admin -->
<nav class="nav nav-pills border rounded p-2">

    <g:link controller="admin" action="index" class="nav-link ${actionName == "index" ? "active" : ""}">
        <g:message code="default.button.admin.estadisticas.message" />
    </g:link>

    <g:link controller="admin" action="platos" class="nav-link ${actionName == "platos" ? "active" : ""}">
        <g:message code="default.button.admin.platos.message" />
    </g:link>

    <g:link controller="admin" action="alergenos" class="nav-link ${actionName == "alergenos" ? "active" : ""}">
        <g:message code="default.button.admin.alergeno.message" />
    </g:link>

    <g:link controller="admin" action="categorias" class="nav-link ${actionName == "categorias" ? "active" : ""}">
        <g:message code="default.button.admin.categorias.message" />
    </g:link>

    <g:link controller="admin" action="ventas" class="nav-link ${actionName == "ventas" ? "active" : ""}">
        <g:message code="default.button.admin.ventas.message" />
    </g:link>

    <g:link controller="admin" action="clientes" class="nav-link ${actionName == "clientes" ? "active" : ""}">
        <g:message code="default.button.admin.clientes.message" />
    </g:link>

    <g:link controller="admin" action="websettings" class="nav-link ${actionName == "websettings" ? "active" : ""}">
        <g:message code="default.button.admin.websettings.message" />
    </g:link>
</nav>