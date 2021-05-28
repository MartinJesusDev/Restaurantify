<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.platos.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="px-0 mt-2 bg-white mx-xl-5 bg-light border rounded">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3 bg-light">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.platos.label"/>
        </h2>
    </div>

<!-- Formulario  -->
    <g:form controller="plato" class="col pb-2 bg-light" enctype="multipart/form-data">
        <!-- Mensaje informativo --->
        <g:if test="${flash.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <g:message code="${flash.message}" />
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </g:if>

        <g:hiddenField name="id" value="${fieldValue(bean: plato,field:"id")}" />
        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control ${hasErrors(bean: plato, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                             name="nombre" value="${fieldValue(bean: plato,field:"nombre")}"/>
                <g:hasErrors bean="${this.plato}" field="nombre">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>

            </div>
            <div class="form-group col-md-2 col-6">
                <label for="precio"><g:message code="default.input.precio.label"/></label>
                <g:textField type="number"  step="0.01" class="form-control ${hasErrors(bean: plato, field: 'precio', 'errors') ? "is-invalid" : ""}"
                             name="precio" value="${fieldValue(bean: plato, field:"precio") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="precio">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="precio" as="list" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group col-md-2 col-6">
                <label for="iva"><g:message code="default.input.plato.iva.label"/></label>
                <g:textField type="number" min="0" step="0.1" class="form-control ${hasErrors(bean: plato, field: 'iva', 'errors') ? "is-invalid" : ""}"
                             name="iva" value="${fieldValue(bean: plato,field:"iva") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="iva">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="iva" as="list" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group col-md-2 col-6">
                <label for="descuento"><g:message code="default.input.plato.descuento.label"/></label>
                <g:textField type="number" min="0" step="0.1" class="form-control ${hasErrors(bean: plato, field: 'descuento', 'errors') ? "is-invalid" : ""}"
                             name="descuento" value="${fieldValue(bean: plato,field:"descuento") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="descuento">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="descuento" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group col-md-2 col-6">
                <label for="tiempoElaboracion"><g:message code="default.input.plato.tmpElaboracion.label"/></label>
                <g:field type="number" min="0" step="1" class="form-control ${hasErrors(bean: plato, field: 'tiempoElaboracion', 'errors') ? "is-invalid" : ""}"
                         name="tiempoElaboracion" value="${fieldValue(bean: plato,field:"tiempoElaboracion") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="tiempoElaboracion">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="tiempoElaboracion" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group col-md-4 col-12">
                <label for="categoria"><g:message code="default.input.plato.categoria.selectdefault.label"/></label>
                <g:select class="custom-select" name="categoria" optionKey="id" optionValue="nombre" from="${listadoCategorias}"
                          value="${fieldValue(bean: plato, field:"categoria.id")}" />
            </div>

            <div class="form-group col-md-4 col-12">
                <label for="alergenos"><g:message code="default.input.plato.alergenos.selectdefault.label"/></label>
                <g:select class="custom-select" name="alergenos" optionKey="id" optionValue="nombre" from="${listadoAlergenos}"
                          multiple="multiple" value="${plato?.alergenos*.id}"
                />
            </div>
            <div class="form-group d-flex justify-content-center align-items-center border rounded col-md-auto col-2 ml-2">
                <asset:image src="platos/${plato?.imagen ?: "img_plato.png"}" class="p-2 pop" width="50px" heigh="50px" />
            </div>
            <div class="form-group col-md-2 col-9">
                <label for="imagenPlato"><g:message code="default.input.platoPicture.label"/></label>
                <g:field type="file" class="form-control h-auto ${hasErrors(bean: plato, field: 'imagenPlato', 'errors') ? "is-invalid" : ""}"
                         name="imagenPlato" />
                <g:hasErrors bean="${this.plato}" field="imagen">
                    <div class="invalid-feedback">
                        <g:renderErrors bean="${plato}" field="imagen" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group d-flex justify-content-center align-items-center col-md-1 col-3">
                <label class="col-form-label" for="disponible"><g:message code="default.input.disponible"/></label>
                <g:checkBox  class="check-box" name="disponible" checked="${plato?.disponible}" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col">
                <label for="alergenos"><g:message code="default.input.plato.elaboracion.label"/></label>
                <g:textArea class="form-control" name="elaboracion" value="${fieldValue(bean: plato, field: "elaboracion" )}" rows="3"  />
            </div>
        </div>

        <div class="form-group">
            <g:actionSubmit action="crear" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="${plato && plato.id}" />
            <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Modify')}" disabled="${!plato || !plato.id}" />
            <button class="btn btn-danger" type="button" id="btnEliminar" ${(!plato || !plato.id) ? "disabled" : "" }><g:message code="default.button.delete.label"/></button>
            <g:link class="btn btn-primary" controller="admin" action="platos"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

<!-- Listado de platos -->
    <div class="col bg-light">
        <table class="col table table-stripped table-hover bg-white border rounded table-responsive-md">
            <tr class="thead-dark">
                <th><g:message code="default.input.platoPicture.label" /> </th>
                <th><g:message code="default.input.name.label" /></th>
                <th><g:message code="default.input.precio.label" /> </th>
                <th><g:message code="default.input.plato.descuento.label" /> </th>
                <th><g:message code="default.input.plato.iva.label" /> </th>
                <th><g:message code="default.input.plato.total.label"/></th>
                <th><g:message code="default.input.seleccionar.label"/> </th>
            </tr>
            <g:each in="${listadoPlatos}" var="p">
                <tr class="${p.id == plato?.id ? "table-active" : ""}">
                    <td class="p-2"><asset:image class="pop image-fluid" src="platos/${p.imagen}" width="70px" height="50px" /> </td>
                    <td>${p.nombre}</td>
                    <td>${p.precio}€</td>
                    <td>${p.descuento}%</td>
                    <td>${p.iva}%</td>
                    <td>${p.total}€</td>
                    <td>
                        <g:link class="btn btn-primary" controller="admin" action="platos" params="[id: p.id]">
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
    (function() {
        // Select2 desplegable
        $(document).ready(function () {
            $('#alergenos').select2({
                closeOnSelect: false
            });
        });

        let btnBorrar = document.getElementById('btnEliminar')
        if(btnBorrar) {
            btnBorrar.addEventListener('click', () => {
                alertUtils(
                    "${message(code: "default.plato.eliminarConfirmar.message")}",
                    "danger",
                    "${message(code: "default.plato.eliminarConfirmar.titulo.message")}",
                    "window.location.replace('/plato/eliminar/${plato?.id ?: ''}')"
                )
            })
        }
    })()
</g:javascript>
</body>
</html>
