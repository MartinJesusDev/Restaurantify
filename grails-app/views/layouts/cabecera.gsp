<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <g:set var="cliente" value="${session?.cliente}"/>
    <title><g:layoutTitle default="Restaurantify" /></title>

    <!-- Icono de la APP -->
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <!-- Estilos de la APP -->
    <asset:stylesheet src="application.css" />

    <g:layoutHead/>
    <style>
    .align-menu {
        display: flex;
        justify-content: flex-end; !important;
    }
    </style>
</head>
<body>
    <!-- Contenedor principal -->
    <div class="container-fluid p-0" style="min-height: 100vh;">

        <!-- Barra de navegación clientes -->
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark px-3 sticky-top">
            <!-- Logo página -->
            <div class="d-flex">
                <asset:image src="restaurante/logotipo.jpg" class="mr-2" alt="Logo web" width="50px" height="50px"/>
                <h1 class="mt-1 font-elegante">
                    <g:link class="text-light" uri="/">Restaurantify</g:link>
                </h1>
            </div>

            <!-- Menu navegación -->
            <div class="collapse navbar-collapse ml-3" id="navbarNav">
                <ul class="navbar-nav" style="font-size: 1.2em;">
                    <li class="nav-item  ${request.forwardURI.matches("/") ? "active" : "" }">
                        <g:link class="nav-link" uri="/" >
                            <g:message code="default.title.inicio.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item  ${request.forwardURI.matches("/plato/lista") ? "active" : "" }">
                        <g:link class="nav-link" controller="plato" action="lista" >
                            <g:message code="default.title.platos.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item ${request.forwardURI == "/cliente/contacto" ? "active" : "" }">
                        <g:link class="nav-link" controller="cliente" action="contacto" >
                            <g:message code="default.title.contacto.label"/>
                        </g:link>
                    </li>
                    <g:if test="${cliente?.rol}" >
                    <li class="nav-item ${request.forwardURI.contains("admin") ? "active" : "" }">
                        <g:link class="nav-link" controller="admin" action="index">
                            <i class="fa fa-tools"></i>
                            <g:message code="default.button.admin.panel.message"/>
                        </g:link>
                    </li>
                    </g:if>
                </ul>
            </div>

            <!-- Panel de herraminetas -->
            <div class="btn-toolbar ml-3" role="toolbar">
            <g:if test="${cliente}" >
            <!-- Panel para cliente identificados -->
                <div class="btn-group" role="group">
                    <g:link class="btn btn-primary" controller="cesta" role="button">
                        <i class="fas fa-shopping-cart mr-2"></i><g:message code="default.button.cesta.message" />
                    </g:link>

                    <!-- Menu herramientas cliente -->
                    <div class="dropdown btn-group" role="group">
                        <button class="btn btn-primary dropdown-toggle" type="button" role="button" id="dropdownMenuLink"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <asset:image src="clientes/${cliente?.imagen}" class="rounded" width="30px" />
                            ${cliente?.nombre}
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <g:link controller="cliente" action="perfil" class="dropdown-item" role="button" >
                                <g:message code="default.button.cliente.perfil.message" />
                            </g:link>
                            <g:link controller="cliente" action="pedidos" class="dropdown-item" role="button">
                                <g:message code="default.button.cliente.pedidos.message" />
                            </g:link>
                            <g:link controller="cliente" action="login" class="dropdown-item" role="button">
                                <g:message code="default.button.cliente.relogin.message" />
                            </g:link>
                            <div class="dropdown-divider"></div>
                            <g:link controller="cliente" action="logout" class="dropdown-item" role="button">
                                <g:message code="default.button.cliente.cerrarSesion.message" />
                            </g:link>
                        </div>
                    </div>
                </div>
                </g:if>
                <g:else>
                <!-- Panel para cliente no identificados -->
                <div class="btn-group" role="group">
                    <g:link controller="cliente" action="login" class="btn btn-dark" role="button">Iniciar sesión</g:link>
                    <g:link controller="cliente" action="registro" class="btn btn-primary" role="button">Registrarse</g:link>
                </div>
                </g:else>
            </div>
        </nav>
    
    <g:layoutBody/>
</body>
</html>
