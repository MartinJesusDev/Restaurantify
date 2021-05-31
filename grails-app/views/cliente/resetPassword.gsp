<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cambiarPassword.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white mx-lg-5" style="min-height: 90vh">
        <div class="d-flex justify-content-center ">
            <div class="col-lg-8 p-0 col bg-light border rounded">
            <!-- Titulo de la página -->
            <div class="mb-3 p-3 bg-dark">
                <h2 class="align-titulo mb-0 text-white font-titulo">
                    <g:message code="default.title.cambiarPassword.label"/>
                </h2>
            </div>

            <div class="p-3 bg-light">
                <!-- Mensaje informativo --->
                <g:if test="${flash.message}">
                    <g:if test="${flash.error}" >
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <g:message code="${flash.message}" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <g:message code="${flash.message}" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </g:else>
                </g:if>

                <!-- Formulario de login -->
                <g:form action="resetPassword" class="bg-light">
                    <g:hiddenField name="email" value="${clientePasswordReset?.email ?: email }" />
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="password"><g:message code="default.input.password.label"/></label>
                            <g:passwordField class="form-control ${hasErrors(bean: clientePasswordReset, field: 'password', 'errors') ? "is-invalid" : ""}"
                                             name="password" value="${fieldValue(bean: clientePasswordReset,field:"password")}"/>
                            <g:hasErrors bean="${this.clientePasswordReset}" field="password">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clientePasswordReset}" field="password" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="repetPassword"><g:message code="default.input.repeatPassword.label"/></label>
                            <g:passwordField class="form-control ${hasErrors(bean: clientePasswordReset, field: 'repetPassword', 'errors') ? "is-invalid" : ""}"
                                             name="repetPassword" value="${fieldValue(bean: clientePasswordReset,field:"repetPassword")}"/>
                            <g:hasErrors bean="${this.clientePasswordReset}" field="repetPassword">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clientePasswordReset}" field="repetPassword" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="resetPassword" class="btn btn-primary " value="${message(code: 'default.button.cambiarPassword.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>