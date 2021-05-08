<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.alergenos.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="p-2 bg-white">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="jumbotron mb-3">
        <h1 class="align-titulo p-3">
            <g:message code="default.title.alergenos.label"/>
        </h1>
    </div>


<!-- Mensaje informativo --->
    <g:if test="${flash.message}">
        <div class="message rounded col-md-4" role="status"><g:message code="${flash.message}"/></div>
    </g:if>

<!-- Formulario  -->
    <g:form controller="alergeno" class="col-md-8" enctype="multipart/form-data">
        <g:hiddenField name="id" value="${fieldValue(bean: alergeno,field:"id")}" />
        <div class="form-row">
            <div class="form-group col">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control" name="nombre" value="${fieldValue(bean: alergeno,field:"nombre")}"/>
                <g:hasErrors bean="${this.alergeno}" field="nombre">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${alergeno}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group d-flex justify-content-center align-items-center border rounded col-auto mx-2">
                <asset:image src="alergenos/${alergeno?.imagen ?: "img_alergeno.png"}" class="p-2 pop" width="50px" heigh="50px" />
            </div>
            <div class="form-group col">
                <label for="imagenAlergeno"><g:message code="default.input.alergenoPicture.label"/></label>
                <g:field type="file" class="form-control h-auto" name="imagenAlergeno" />
                <g:hasErrors bean="${this.alergeno}" field="imagen">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${alergeno}" field="imagen" as="list" />
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="form-group">
            <g:actionSubmit action="crear" class="btn btn-primary " value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="${alergeno && alergeno.id}" />
            <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Modify')}" disabled="${!alergeno || !alergeno.id}" />
            <g:actionSubmit action="eliminar" class="btn btn-danger" value="${message(code: 'default.button.delete.label', default: 'Delete')}" disabled="${!alergeno || !alergeno.id}" />
            <g:link class="btn btn-primary" controller="admin" action="alergenos"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

    <!-- Listado de alergenos -->
    <div class="col justify-content-center">
        <table class="col table table-stripped table-hover">
            <tr>
                <th><g:message code="default.input.imagen.label" /> </th>
                <th><g:message code="default.input.name.label" /></th>
                <th><g:message code="default.input.seleccionar.label"/> </th>
            </tr>
            <g:each in="${listadoAlergenos}" var="a">
                <tr class="${a.id == alergeno?.id ? "table-active" : ""}">
                    <td><asset:image class="pop" src="alergenos/${a.imagen}" width="35px" /> </td>
                    <td>${a.nombre}</td>
                    <td>
                        <g:link class="btn btn-primary" controller="admin" action="alergenos" params="[id: a.id]">
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
