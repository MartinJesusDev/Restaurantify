<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.login.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white mx-lg-5" style="min-height: 90vh">
        <div class="d-flex justify-content-center ">
            <div class="col-lg-8 p-0 col bg-light border rounded">
            <!-- Titulo de la página -->
            <div class="mb-3 p-3 bg-dark">
                <h2 class="align-titulo mb-0 text-white font-titulo">
                    <g:message code="default.title.cliente.login.label"/>
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
                <g:form action="login" class="bg-light">
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="email"><g:message code="default.input.email.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: clienteLogin, field: 'email', 'errors') ? "is-invalid" : ""}"
                                         name="email" value="${fieldValue(bean: clienteLogin,field:"email")}"/>
                            <g:hasErrors bean="${this.clienteLogin}" field="email">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteLogin}" field="email" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="password"><g:message code="default.input.password.label"/></label>
                            <g:passwordField class="form-control ${hasErrors(bean: clienteLogin, field: 'password', 'errors') ? "is-invalid" : ""}"
                                             name="password" value="${fieldValue(bean: clienteLogin,field:"password")}"/>
                            <g:hasErrors bean="${this.clienteLogin}" field="password">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${clienteLogin}" field="password" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-group">
                        <g:link class="btn-link" action="restablecer" controller="cliente"><g:message code="default.button.restablecer.label" /> </g:link>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="login" class="btn btn-primary " value="${message(code: 'default.button.login.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>