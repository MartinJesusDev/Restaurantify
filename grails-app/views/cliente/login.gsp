<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.login.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white">
        <!-- Titulo de la página -->
        <div class="col mb-3">
            <h1 class="align-titulo p-3 bg-light">
                <g:message code="default.title.cliente.login.label"/>
            </h1>
        </div>

        <!-- Mensaje informativo --->
        <g:if test="${flash.message}">
            <g:if test="${flash.error}" >
                <div class="errors rounded col-md-4" role="alert"><li>${flash.message}</li></div>
            </g:if>
            <g:else>
                <div class="message rounded col-md-4" role="status">${flash.message}</div>
            </g:else>
        </g:if>

        <!-- Formulario de login -->
        <g:form action="login" class="col-md-4">
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
    </section>

    <g:applyLayout name="pie" />
</body>
</html>