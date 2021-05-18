<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.cliente.perfil.label"/></title>
</head>
<body>
    <!-- Sección del formulario --->
    <section class="p-2 bg-white">
        <!-- Titulo de la página -->
        <div class="col mb-3">
            <h1 class="align-titulo p-3 bg-light font-titulo">
                <g:message code="default.title.cliente.perfil.label"/>
            </h1>
        </div>


        <!-- Formulario de perfil -->
        <div class="d-flex">
            <g:form action="perfil" class="col-md-6" enctype="multipart/form-data" >
                <!-- Mensaje informativo --->
                <g:if test="${flash.message}">
                    <div class="message rounded col ml-0" role="status"><g:message code="${flash.message}" /></div>
                </g:if>

                <g:hiddenField name="id" value="${fieldValue(bean: cliente,field:"id")}"/>
                <div class="form-row">
                    <div class="form-group col">
                        <label for="nombre"><g:message code="default.input.name.label"/></label>
                        <g:textField class="form-control" name="nombre" value="${fieldValue(bean: cliente,field:"nombre")}"/>
                        <g:hasErrors bean="${this.cliente}" field="nombre">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="nombre" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="apellidos"><g:message code="default.input.surname.label"/></label>
                        <g:textField class="form-control" name="apellidos" value="${fieldValue(bean: cliente,field:"apellidos")}"/>
                        <g:hasErrors bean="${this.cliente}" field="apellidos">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="apellidos" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="email"><g:message code="default.input.email.label"/></label>
                        <g:hiddenField name="oldEmail" value="${fieldValue(bean: cliente,field:"email")}" />
                        <g:textField class="form-control" name="email" value="${fieldValue(bean: cliente,field:"email")}"/>
                        <g:hasErrors bean="${this.cliente}" field="email">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="email" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="password"><g:message code="default.input.password.label"/></label>
                        <g:hiddenField name="oldPassword" value="${fieldValue(bean: cliente,field:"password")}" />
                        <g:passwordField class="form-control" name="password" value="${fieldValue(bean: cliente,field:"password")}"/>
                        <g:hasErrors bean="${this.cliente}" field="password">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="password" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="dni"><g:message code="default.input.dni.label"/></label>
                        <g:textField class="form-control" name="dni" value="${fieldValue(bean: cliente,field:"dni")}"/>
                        <g:hasErrors bean="${this.cliente}" field="dni">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="dni" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="cp"><g:message code="default.input.cp.label"/></label>
                        <g:textField class="form-control" name="cp" value="${fieldValue(bean: cliente,field:"cp")}"/>
                        <g:hasErrors bean="${this.cliente}" field="cp">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="cp" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="provincia"><g:message code="default.input.province.label"/></label>
                        <g:textField class="form-control" name="provincia" value="${fieldValue(bean: cliente,field:"provincia")}"/>
                        <g:hasErrors bean="${this.cliente}" field="provincia">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="provincia" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="localidad"><g:message code="default.input.locality.label"/></label>
                        <g:textField class="form-control" name="localidad" value="${fieldValue(bean: cliente,field:"localidad")}"/>
                        <g:hasErrors bean="${this.cliente}" field="localidad">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="localidad" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="calle"><g:message code="default.input.street.label"/></label>
                        <g:textField class="form-control" name="calle" value="${fieldValue(bean: cliente,field:"calle")}"/>
                        <g:hasErrors bean="${this.cliente}" field="calle">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="calle" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <label for="fechaDeNacimiento"><g:message code="default.input.birthday.label"/></label>
                        <g:field type="date" class="form-control" name="fechaDeNacimiento"
                                      value="${fieldValue(bean: cliente,field:"fechaDeNacimiento")}"
                                      precision="day"
                        />
                        <g:hasErrors bean="${this.cliente}" field="fechaDeNacimiento">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="fechaDeNacimiento" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group d-flex justify-content-center align-items-center border rounded col-auto mr-2">
                        <asset:image src="clientes/${cliente.imagen}" class="p-2 pop" width="50px" heigh="50px" />
                    </div>
                    <div class="form-group col">
                        <label for="imagenPerfil"><g:message code="default.input.profilePicture.label"/></label>
                        <g:field type="file" class="form-control h-auto" name="imagenPerfil" />
                        <g:hasErrors bean="${this.cliente}" field="imagen">
                            <div class="errors mx-0 my-1 py-0 rounded" role="alert">
                                <g:renderErrors bean="${cliente}" field="imagen" as="list" />
                            </div>
                        </g:hasErrors>
                    </div>
                </div>


                <div class="form-group">
                    <g:submitButton name="actualizar" class="btn btn-primary" value="${message(code: 'default.button.cliente.actualizar.message', default: 'Actualizar')}" />
                    <g:link name="borrarCuenta" controller="cliente" action="borrarCuenta" class="btn btn-danger">
                        <g:message code="default.button.cliente.eliminarCuenta.message"/>
                    </g:link>
                </div>
            </g:form>
        </div>
    </section>

    <g:applyLayout name="pie" />
</body>
</html>