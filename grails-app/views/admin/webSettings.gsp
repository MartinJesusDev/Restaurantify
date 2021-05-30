<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.webSettings.label"/></title>
</head>
<body>
<!-- Sección del formulario --->
<section class="px-0 mt-2 mx-xl-5 mb-4 bg-light border rounded">
    <g:applyLayout name="adminNavbar" />

    <!-- Titulo de la página -->
    <div class="p-3">
        <h2 class="align-titulo font-titulo">
            <g:message code="default.title.webSettings.label"/>
        </h2>
        <div class="col px-0 py-3 bg-light">
        <!-- Mensaje informativo --->
            <g:if test="${flash.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <g:message code="${flash.message}" />
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </g:if>

            <!-- Formulario  -->
            <g:form controller="webSettings" enctype="multipart/form-data">
                <g:hiddenField name="id" value="${fieldValue(bean: webSettings, field:"id")}" />
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="nombre"><g:message code="default.input.webSettings.nombre.label" /></label>
                        <g:field class="form-control ${hasErrors(bean: webSettings, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                                 type="text" name="nombre" value="${fieldValue(bean: webSettings,field:"nombre")}" />
                        <g:hasErrors bean="${this.webSettings}" field="nombre">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="nombre" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-4">
                        <div class="d-flex">
                            <div class="bg-dark border border-dark rounded p-1">
                                <asset:image src="restaurante/${webSettings?.imgLogotipo ?: "logotipo.jpg"}"
                                     class="pop" width="60px" height="auto" />
                            </div>
                            <div class="col">
                                <label for="imagen"><g:message code="default.input.webSettings.imgLogotipo.label"/></label>
                                <g:field type="file" class="form-control ${hasErrors(bean: webSettings, field: 'imgLogotipo', 'errors') ? "is-invalid" : ""}"
                                         name="imagen" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <div class="d-flex">
                            <div class="border border-dark rounded d-flex justify-content-center align-items-center" id="colorChoosed"
                                 style="width: 70px;height: auto;background-color:${webSettings.color};">
                                <span class="text-white">Color</span>
                            </div>
                            <div class="col">
                                <label for="color"><g:message code="default.input.webSettings.color.label" /></label>
                                <g:select class="custom-select ${hasErrors(bean: webSettings, field: 'color', 'errors') ? "is-invalid" : ""}"
                                          from="${webSettings.listaColores}" name="color"
                                          optionValue="value" optionKey="key" value="${fieldValue(bean: webSettings,field:"color")}"/>
                            </div>
                        </div>
                        <g:hasErrors bean="${this.webSettings}" field="color">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="color" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-2 col-6">
                        <label for="color"><g:message code="default.input.webSettings.alignMenu.label" /></label>

                        <g:select class="custom-select ${hasErrors(bean: webSettings, field: 'alignMenu', 'errors') ? "is-invalid" : ""}"
                                  from="${webSettings.alineacion}" name="alignMenu"
                                  optionValue="value" optionKey="key" value="${fieldValue(bean: webSettings,field:"alignMenu")}"/>
                        <g:hasErrors bean="${this.webSettings}" field="alignMenu">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="alignMenu" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="color"><g:message code="default.input.webSettings.alignTitulos.label" /></label>
                        <g:select class="custom-select ${hasErrors(bean: webSettings, field: 'alignTitulos', 'errors') ? "is-invalid" : ""}"
                                  from="${webSettings.alineacion}" name="alignTitulos"
                                  optionValue="value" optionKey="key" value="${fieldValue(bean: webSettings,field:"alignTitulos")}"/>
                        <g:hasErrors bean="${this.webSettings}" field="alignTitulos">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="alignTitulos" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="ventasPorPagina"><g:message code="default.input.webSettings.ventasXPagina.label" /></label>
                        <g:field type="number" name="ventasPorPagina"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'ventasPorPagina', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"ventasPorPagina")}" />
                        <g:hasErrors bean="${this.webSettings}" field="ventasPorPagina">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="ventasPorPagina" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="pedidosPorPagina"><g:message code="default.input.webSettings.pedidosXPagina.label" /></label>
                        <g:field type="number" name="pedidosPorPagina"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'pedidosPorPagina', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"pedidosPorPagina")}" />
                        <g:hasErrors bean="${this.webSettings}" field="pedidosPorPagina">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="pedidosPorPagina" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="valoracionesPorPagina"><g:message code="default.input.webSettings.valoracionesXPagina.label" /></label>
                        <g:field type="number" name="valoracionesPorPagina"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'valoracionesPorPagina', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"valoracionesPorPagina")}" />
                        <g:hasErrors bean="${this.webSettings}" field="valoracionesPorPagina">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="valoracionesPorPagina" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="maxPlatosPedido"><g:message code="default.input.webSettings.maxPlatosPedido.label" /></label>
                        <g:field type="number" name="maxPlatosPedido"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'maxPlatosPedido', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"maxPlatosPedido")}" />
                        <g:hasErrors bean="${this.webSettings}" field="maxPlatosPedido">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="maxPlatosPedido" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="gastosDeEnvio"><g:message code="default.input.webSettings.gastosEnvio.label" /></label>
                        <g:field type="number" name="gastosDeEnvio"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'gastosDeEnvio', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"gastosDeEnvio")}" />
                        <g:hasErrors bean="${this.webSettings}" field="gastosDeEnvio">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="gastosDeEnvio" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                    <div class="form-group col-md-2 col-6">
                        <label for="gastosDeEnvioGratis"><g:message code="default.input.webSettings.gastosEnvioGratis.label" /></label>
                        <g:field type="number" name="gastosDeEnvioGratis"
                                 class="form-control ${hasErrors(bean: webSettings, field: 'gastosDeEnvioGratis', 'errors') ? "is-invalid" : ""}"
                                 step="1" value="${fieldValue(bean: webSettings,field:"gastosDeEnvioGratis")}" />
                        <g:hasErrors bean="${this.webSettings}" field="gastosDeEnvioGratis">
                            <div class="invalid-feedback">
                                <g:renderErrors bean="${webSettings}" field="gastosDeEnvioGratis" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <g:actionSubmit class="btn btn-primary" controller="webSettings" action="modificar" value="${message(code: "default.button.update.label")}" />
                    </div>
                </div>
            </g:form>
        </div>
    </div>

</section>

<g:applyLayout name="pie" />
<script>
    // Cambio de color automatico
    $('#color').change(function () {
        $('#colorChoosed').css('background-color', this.value)
    })
</script>
</body>
</html>
