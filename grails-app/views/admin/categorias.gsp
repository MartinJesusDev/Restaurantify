<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.categorias.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="p-2 bg-white">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="jumbotron mb-3">
        <h1 class="align-titulo p-3">
            <g:message code="default.title.categorias.label"/>
        </h1>
    </div>


<!-- Mensaje informativo --->
    <g:if test="${flash.message}">
        <div class="message rounded col-md-4" role="status"><g:message code="${flash.message}" /></div>
    </g:if>

<!-- Formulario  -->
    <g:form controller="categoria" class="col-md-8" enctype="multipart/form-data">
        <g:hiddenField name="id" value="${fieldValue(bean: categoria,field:"id")}" />
        <div class="form-row">
            <div class="form-group col">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control" name="nombre" value="${fieldValue(bean: categoria,field:"nombre")}"/>
                <g:hasErrors bean="${this.categoria}" field="nombre">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${categoria}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group col">
                <label for="orden"><g:message code="default.input.orden.label"/></label>
                <g:field type="number" class="form-control h-auto" name="orden" min="1" value="${fieldValue(bean: categoria,field:"orden")}" />
                <g:hasErrors bean="${this.categoria}" field="orden">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${categoria}" field="orden" as="list" />
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="form-group">
            <g:actionSubmit action="crear" class="btn btn-primary " value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="${categoria && categoria.id}" />
            <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Modify')}" disabled="${!categoria || !categoria.id}" />
            <g:actionSubmit action="eliminar" class="btn btn-danger" value="${message(code: 'default.button.delete.label', default: 'Delete')}" disabled="${!categoria || !categoria.id}" />
            <g:link class="btn btn-primary" controller="admin" action="categorias"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

<!-- Listado de categorias -->
    <div class="col justify-content-center">
        <table class="col table table-stripped table-hover">
            <tr>
                <th><g:message code="default.input.name.label" /></th>
                <th><g:message code="default.input.orden.label" /> </th>
                <th><g:message code="default.input.seleccionar.label"/> </th>
            </tr>
            <g:each in="${listadoCategorias}" var="c">
                <tr class="${c.id == categoria?.id ? "table-active" : ""}">
                    <td>${c.nombre}</td>
                    <td>${c.orden}</td>
                    <td>
                        <g:link class="btn btn-primary" controller="admin" action="categorias" params="[id: c.id]">
                            <i class="fas fa-pen"></i>
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
</section>

<g:applyLayout name="pie" />
</body>
</html>
