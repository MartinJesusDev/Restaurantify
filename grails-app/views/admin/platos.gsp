<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.platos.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="p-2 bg-white">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="jumbotron mb-3">
        <h1 class="align-titulo p-3">
            <g:message code="default.title.platos.label"/>
        </h1>
    </div>


<!-- Mensaje informativo --->
    <g:if test="${flash.message}">
        <div class="message rounded col-md-4" role="status"><g:message code="${flash.message}"/></div>
    </g:if>

<!-- Formulario  -->
    <g:form controller="plato" class="col-md-8" enctype="multipart/form-data">
        <g:hiddenField name="id" value="${fieldValue(bean: plato,field:"id")}" />
        <div class="form-row">
            <div class="form-group col">
                <label for="nombre"><g:message code="default.input.name.label"/></label>
                <g:textField class="form-control" name="nombre" value="${fieldValue(bean: plato,field:"nombre")}"/>
                <g:hasErrors bean="${this.plato}" field="nombre">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="nombre" as="list" />
                    </div>
                </g:hasErrors>

            </div>
            <div class="form-group col-1">
                <label for="precio"><g:message code="default.input.precio.label"/></label>
                <g:textField type="number"  step="0.01" class="form-control" name="precio" value="${fieldValue(bean: plato, field:"precio") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="precio">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="precio" as="list" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group col-1">
                <label for="iva"><g:message code="default.input.plato.iva.label"/></label>
                <g:textField type="number" min="0" step="0.1" class="form-control" name="iva" value="${fieldValue(bean: plato,field:"iva") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="iva">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="iva" as="list" />
                    </div>
                </g:hasErrors>
            </div>

            <div class="form-group col-1">
                <label for="descuento"><g:message code="default.input.plato.descuento.label"/></label>
                <g:textField type="number" min="0" step="0.1" class="form-control" name="descuento" value="${fieldValue(bean: plato,field:"descuento") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="descuento">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="descuento" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group col-2">
                <label for="tiempoElaboracion"><g:message code="default.input.plato.tmpElaboracion.label"/></label>
                <g:field type="number" min="0" step="1" class="form-control" name="tiempoElaboracion" value="${fieldValue(bean: plato,field:"tiempoElaboracion") ?: 0}" />
                <g:hasErrors bean="${this.plato}" field="tiempoElaboracion">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="tiempoElaboracion" as="list" />
                    </div>
                </g:hasErrors>
            </div>
            <div class="form-group d-flex justify-content-center align-items-center col-1">
                <label class="col-form-label" for="disponible"><g:message code="default.input.disponible"/></label>
                <g:checkBox  class="check-box" name="disponible" checked="${plato?.disponible}" />
            </div>
        </div>

        <div class="form-row" >
            <div class="form-group col">
                <label for="categoria"><g:message code="default.input.plato.categoria.selectdefault.label"/></label>
                <g:select class="custom-select" name="categoria" optionKey="id" optionValue="nombre" from="${listadoCategorias}"
                          value="${fieldValue(bean: plato, field:"categoria.id")}" />
            </div>

            <div class="form-group col">
                <label for="alergenos"><g:message code="default.input.plato.alergenos.selectdefault.label"/></label>
                <g:select class="custom-select" name="alergenos" optionKey="id" optionValue="nombre" from="${listadoAlergenos}"
                          multiple="multiple" value="${plato?.alergenos*.id}"
                />
            </div>
            <div class="form-group d-flex justify-content-center align-items-center border rounded col-auto mx-2">
                <asset:image src="platos/${plato?.imagen ?: "img_plato.png"}" class="p-2 pop" width="50px" heigh="50px" />
            </div>
            <div class="form-group col">
                <label for="imagenPlato"><g:message code="default.input.platoPicture.label"/></label>
                <g:field type="file" class="form-control h-auto" name="imagenPlato" />
                <g:hasErrors bean="${this.plato}" field="imagen">
                    <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                        <g:renderErrors bean="${plato}" field="imagen" as="list" />
                    </div>
                </g:hasErrors>
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
            <g:actionSubmit action="eliminar" class="btn btn-danger" value="${message(code: 'default.button.delete.label', default: 'Delete')}" disabled="${!plato || !plato.id}" />
            <g:link class="btn btn-primary" controller="admin" action="platos"><g:message code="default.button.reset.label"/></g:link>
        </div>
    </g:form>

<!-- Listado de platos -->
    <div class="col justify-content-center">
        <table class="col table table-stripped table-hover">
            <tr>
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
                    <td><asset:image class="pop" src="platos/${p.imagen}" width="35px" /> </td>
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
    // Select2 desplegable
    $(document).ready(function() {
        $('#alergenos').select2({
            closeOnSelect: false
        });
    });
</g:javascript>
</body>
</html>
