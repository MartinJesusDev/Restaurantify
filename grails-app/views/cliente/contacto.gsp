<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.contacto.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="d-flex justify-content-center p-2 bg-white mx-lg-5 mb-3">
        <div class="col-lg-8 p-0 col bg-light border rounded">
            <!-- Titulo de la página -->
            <div class="mb-3 p-3 bg-dark text-white">
                <h2 class="align-titulo font-titulo">
                    <g:message code="default.title.contacto.label"/>
                </h2>
                <p class="mb-3 font-weight-normal">
                    <g:message code="default.input.pie.contacto1.message"/>
                    <g:message code="default.input.pie.contacto2.message"/>
                    <b><g:message code="default.input.pie.contacto3.message"/></b>
                </p>
                <a class="btn btn-primary" href="tel:945 110 320"><i class="fas fa-phone-alt mr-2"></i>945 110 320</a>
            </div>

            <div class="p-3 bg-light">
                 <!-- Mensaje informativo --->
                <g:if test="${flash.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <g:message code="${flash.message}" />
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </g:if>

                 <!-- Formulario de registro -->
                <g:form controller="cliente" action="contacto" class="bg-light" enctype="multipart/form-data" >
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="nombre"><g:message code="default.input.name.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: clienteMensaje, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                                         name="nombre" value="${fieldValue(bean: clienteMensaje,field:"nombre")}"/>
                            <g:hasErrors bean="${this.clienteMensaje}" field="nombre">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteMensaje}" field="nombre" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="email"><g:message code="default.input.email.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: clienteMensaje, field: 'email', 'errors') ? "is-invalid" : ""}"
                                         name="email" value="${fieldValue(bean: clienteMensaje,field:"email")}"/>
                            <g:hasErrors bean="${this.clienteMensaje}" field="email">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteMensaje}" field="email" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="motivo"><g:message code="default.input.motivo.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: clienteMensaje, field: 'motivo', 'errors') ? "is-invalid" : ""}"
                                         name="motivo" value="${fieldValue(bean: clienteMensaje,field:"motivo")}" />
                            <g:hasErrors bean="${this.clienteMensaje}" field="motivo">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteMensaje}" field="motivo" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="mensaje"><g:message code="default.input.mensaje.label"/></label>
                            <g:textArea class="form-control ${hasErrors(bean: clienteMensaje, field: 'mensaje', 'errors') ? "is-invalid" : ""}"
                                         name="mensaje" value="${fieldValue(bean: clienteMensaje,field:"mensaje")}"
                                        rows="5" cols="40" />
                            <g:hasErrors bean="${this.clienteMensaje}" field="mensaje">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteMensaje}" field="mensaje" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="enviar" class="btn btn-primary " value="${message(code: 'default.button.enviarForm.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>