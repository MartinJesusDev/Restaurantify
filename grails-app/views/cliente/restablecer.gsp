<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.restablecer.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white mx-lg-5" style="min-height: 90vh">
        <div class="d-flex justify-content-center ">
            <div class="col-lg-8 p-0 col bg-light border rounded">
            <!-- Titulo de la página -->
            <div class="mb-3 p-3 bg-dark">
                <h2 class="align-titulo mb-0 text-white font-titulo">
                    <g:message code="default.title.restablecer.label"/>
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
                <g:form controller="cliente" action="restablecer" class="bg-light">
                    <p><g:message code="default.cliente.restablecerInfo.message"/></p>
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="email"><g:message code="default.input.email.label"/></label>
                            <g:field type="email" class="form-control" name="email" />
                        </div>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="restablecer" class="btn btn-primary " value="${message(code: 'default.button.enviarForm.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>