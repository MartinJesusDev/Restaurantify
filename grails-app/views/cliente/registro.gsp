<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.registro.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="d-flex justify-content-center p-2 bg-white mx-lg-5">
        <div class="col-lg-8 p-0 col bg-light border rounded">
            <!-- Titulo de la página -->
            <div class="mb-3 p-3 bg-dark">
                <h2 class="align-titulo mb-0 text-white font-titulo">
                    <g:message code="default.title.cliente.registro.label"/>
                </h2>
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
                <g:form action="registro" class="bg-light" enctype="multipart/form-data" >
                    <div class="form-row">
                        <div class="form-group col">
                            <label for="nombre"><g:message code="default.input.name.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'nombre', 'errors') ? "is-invalid" : ""}"
                                         name="nombre" value="${fieldValue(bean: cliente,field:"nombre")}"/>
                            <g:hasErrors bean="${this.cliente}" field="nombre">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="nombre" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="apellidos"><g:message code="default.input.surname.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'apellidos', 'errors') ? "is-invalid" : ""}"
                                         name="apellidos" value="${fieldValue(bean: cliente,field:"apellidos")}"/>
                            <g:hasErrors bean="${this.cliente}" field="apellidos">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="apellidos" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="email"><g:message code="default.input.email.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'email', 'errors') ? "is-invalid" : ""}"
                                         name="email" value="${fieldValue(bean: cliente,field:"email")}"/>
                            <g:hasErrors bean="${this.cliente}" field="email">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="email" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="password"><g:message code="default.input.password.label"/></label>
                            <g:passwordField class="form-control ${hasErrors(bean: cliente, field: 'password', 'errors') ? "is-invalid" : ""}"
                                             name="password" value="${fieldValue(bean: cliente,field:"password")}"/>
                            <g:hasErrors bean="${this.cliente}" field="password">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="password" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="dni"><g:message code="default.input.dni.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'dni', 'errors') ? "is-invalid" : ""}"
                                         name="dni" value="${fieldValue(bean: cliente,field:"dni")}"/>
                            <g:hasErrors bean="${this.cliente}" field="dni">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="dni" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="cp"><g:message code="default.input.cp.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'cp', 'errors') ? "is-invalid" : ""}"
                                         name="cp" value="${fieldValue(bean: cliente,field:"cp")}"/>
                            <g:hasErrors bean="${this.cliente}" field="cp">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="cp" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="provincia"><g:message code="default.input.province.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'provincia', 'errors') ? "is-invalid" : ""}"
                                         name="provincia" value="${fieldValue(bean: cliente,field:"provincia")}"/>
                            <g:hasErrors bean="${this.cliente}" field="provincia">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="provincia" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="localidad"><g:message code="default.input.locality.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'localidad', 'errors') ? "is-invalid" : ""}"
                                         name="localidad" value="${fieldValue(bean: cliente,field:"localidad")}"/>
                            <g:hasErrors bean="${this.cliente}" field="localidad">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="localidad" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="calle"><g:message code="default.input.street.label"/></label>
                            <g:textField class="form-control ${hasErrors(bean: cliente, field: 'calle', 'errors') ? "is-invalid" : ""}"
                                         name="calle" value="${fieldValue(bean: cliente,field:"calle")}"/>
                            <g:hasErrors bean="${this.cliente}" field="calle">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="calle" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="fechaDeNacimiento"><g:message code="default.input.birthday.label"/></label>
                            <g:field type="date" class="form-control ${hasErrors(bean: cliente, field: 'fechaDeNacimiento', 'errors') ? "is-invalid" : ""}"
                                     name="fechaDeNacimiento"
                                          value="${fieldValue(bean: cliente,field:"fechaDeNacimiento")}"
                                          precision="day"
                            />
                            <g:hasErrors bean="${this.cliente}" field="fechaDeNacimiento">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="fechaDeNacimiento" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col">
                            <label for="imagenPerfil"><g:message code="default.input.profilePicture.label"/></label>
                            <g:field type="file" class="form-control h-auto" name="imagenPerfil" />
                            <g:hasErrors bean="${this.cliente}" field="imagen">
                                <div class="invalid-feedback">
                                    <g:renderErrors bean="${cliente}" field="imagen" as="list" />
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>

                    <div class="form-group">
                        <g:submitButton name="create" class="btn btn-primary " value="${message(code: 'default.button.register.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>