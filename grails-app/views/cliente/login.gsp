<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.login.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white" style="min-height: 80vh">
        <!-- Titulo de la página -->
        <div class="col mb-3">
            <h2 class="align-titulo p-3 bg-light font-titulo">
                <g:message code="default.title.cliente.login.label"/>
            </h2>
        </div>

        <!-- Formulario de login -->
        <div class="d-flex ">
            <g:form action="login" class="col-md-6">
                <!-- Mensaje informativo --->
                <g:if test="${flash.message}">
                    <g:if test="${flash.error}" >
                        <div class="errors rounded col ml-0" role="alert"><li><g:message code="${flash.message}" /></li></div>
                    </g:if>
                    <g:else>
                        <div class="message rounded col ml-0" role="status"><g:message code="${flash.message}" /></div>
                    </g:else>
                </g:if>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="email"><g:message code="default.input.email.label"/></label>
                        <g:textField class="form-control" name="email" value="${fieldValue(bean: clienteLogin,field:"email")}"/>
                        <g:hasErrors bean="${this.clienteLogin}" field="email">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${clienteLogin}" field="email" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="password"><g:message code="default.input.password.label"/></label>
                        <g:passwordField class="form-control" name="password" value="${fieldValue(bean: clienteLogin,field:"password")}"/>
                        <g:hasErrors bean="${this.clienteLogin}" field="password">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${this.clienteLogin}" field="password" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>


                <div class="form-group">
                    <g:submitButton name="login" class="btn btn-primary " value="${message(code: 'default.button.login.label', default: 'Create')}" />
                </div>
            </g:form>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>