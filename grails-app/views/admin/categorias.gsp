<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.categorias.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="px-0 mx-xl-5 mt-2 border rounded bg-light">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.categorias.label"/>
        </h2>
    </div>


<!-- Mensaje informativo --->
    <g:if test="${flash.message}">
        <div class="message rounded col" role="status"><g:message code="${flash.message}" /></div>
    </g:if>

<!-- Formulario  -->
    <g:form controller="categoria" class="col mb-4" enctype="multipart/form-data">
        <g:hiddenField name="id" value="${fieldValue(bean: categoria,field:"id")}" />
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control ${hasErrors(bean: categoria, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                             name="nombre" value="${fieldValue(bean: categoria,field:"nombre")}"/>
                <g:hasErrors bean="${this.categoria}" field="nombre">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${categoria}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group col-md-6">
                <label for="orden"><g:message code="default.input.orden.label"/></label>
                <g:field type="number" class="form-control ${hasErrors(bean: categoria, field: 'orden', 'errors') ? "is-invalid" : ""}"
                         name="orden" min="1" value="${fieldValue(bean: categoria,field:"orden")}" />
                <g:hasErrors bean="${this.categoria}" field="orden">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${categoria}" field="orden" as="list" />
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="form-group">
            <g:actionSubmit action="crear" class="btn btn-primary " value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="${categoria && categoria.id}" />
            <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Modify')}" disabled="${!categoria || !categoria.id}" />
            <button class="btn btn-danger" type="button" id="btnEliminar" ${(!categoria || !categoria.id) ? "disabled" : "" }><g:message code="default.button.delete.label"/></button>
            <g:link class="btn btn-primary" controller="admin" action="categorias"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

<!-- Listado de categorias -->
    <div class="col">
        <table class="col table table-stripped table-hover bg-white border rounded table-responsive-md">
            <tr class="thead-dark">
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
<g:javascript>
    (function (){
        let btnBorrar = document.getElementById('btnEliminar')
        if(btnBorrar) {
            btnBorrar.addEventListener('click', () => {
                alertUtils(
                    "${message(code: "default.categoria.eliminarConfirmar.message")}",
                    "danger",
                    "${message(code: "default.categoria.eliminarConfirmar.titulo.message")}",
                    "window.location.replace('/categoria/eliminar/${categoria?.id ?: ''}')"
                )
            })
        }
    })()
</g:javascript>
</body>
</html>
