<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.alergenos.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class=" px-0 mt-2 mx-xl-5 bg-light border rounded">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.alergenos.label"/>
        </h2>
    </div>


<!-- Mensaje informativo --->
    <g:if test="${flash.message}">
        <div class="message rounded col" role="status"><g:message code="${flash.message}"/></div>
    </g:if>

<!-- Formulario  -->
    <g:form controller="alergeno" class="col mb-4" enctype="multipart/form-data">
        <g:hiddenField name="id" value="${fieldValue(bean: alergeno,field:"id")}" />
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control ${hasErrors(bean: alergeno, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                             name="nombre" value="${fieldValue(bean: alergeno,field:"nombre")}"/>
                <g:hasErrors bean="${this.alergeno}" field="nombre">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${alergeno}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group d-flex justify-content-center align-items-center border rounded col-auto mx-2">
                <asset:image src="alergenos/${alergeno?.imagen ?: "img_alergeno.png"}" class="p-2 pop" width="50px" heigh="50px" />
            </div>
            <div class="form-group col-md-5 col-9">
                <label for="imagenAlergeno"><g:message code="default.input.alergenoPicture.label"/></label>
                <g:field type="file" class="form-control h-auto ${hasErrors(bean: alergeno, field: 'imagen', 'errors') ? "is-invalid" : ""}"
                         name="imagenAlergeno" />
                <g:hasErrors bean="${this.alergeno}" field="imagen">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${alergeno}" field="imagen" as="list" />
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="form-group">
            <g:actionSubmit action="crear" class="btn btn-primary " value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="${alergeno && alergeno.id}" />
            <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Modify')}" disabled="${!alergeno || !alergeno.id}" />
            <button class="btn btn-danger" type="button" id="btnEliminar" ${(!alergeno || !alergeno.id) ? "disabled" : "" }><g:message code="default.button.delete.label"/></button>
            <g:link class="btn btn-primary" controller="admin" action="alergenos"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

    <!-- Listado de alergenos -->
    <div class="col">
        <table class="col table table-hover bg-white border rounded table-responsive-md">
            <tr class="thead-dark">
                <th><g:message code="default.input.imagen.label" /> </th>
                <th><g:message code="default.input.name.label" /></th>
                <th><g:message code="default.input.seleccionar.label"/> </th>
            </tr>
            <g:each in="${listadoAlergenos}" var="a">
                <tr class="${a.id == alergeno?.id ? "table-active" : ""}">
                    <td class="p-2"><asset:image class="pop image-fluid" src="alergenos/${a.imagen}" width="50px" /> </td>
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
<g:javascript>
    (function(){
        let btnBorrar = document.getElementById('btnEliminar')
        if(btnBorrar) {
            btnBorrar.addEventListener('click', () => {
                alertUtils(
                    "${message(code: "default.alergeno.eliminarConfirmar.message")}",
                    "danger",
                    "${message(code: "default.alergeno.eliminarConfirmar.titulo.message")}",
                    "window.location.replace('/alergeno/eliminar/${alergeno?.id ?: ''}')"
                )
            })
        }
    })()
</g:javascript>
</body>
</html>
