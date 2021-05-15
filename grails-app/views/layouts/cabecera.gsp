<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
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
                <asset:image src="restaurante/logotipo.jpg" class="mr-1" alt="Logo web" width="50px" height="50px"/>
                <h1>
                    <g:link class="text-light" uri="/">Restaurantify</g:link>
                </h1>
            </div>

            <!-- Menu navegación -->
            <div class="collapse navbar-collapse ml-3 w-100" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">
                        <g:link class="nav-link ${request.forwardURI.matches("/") ? "active" : "" }" uri="/" >
                            <g:message code="default.title.inicio.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item">
                        <g:link class="nav-link ${request.forwardURI.matches("/plato/lista") ? "active" : "" }" controller="plato" action="lista" >
                            <g:message code="default.title.platos.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item">
                        <g:link class="nav-link ${request.forwardURI == "/cliente/contacto" ? "active" : "" }" controller="cliente" action="contacto" >
                            <g:message code="default.title.contacto.label"/>
                        </g:link>
                    </li>
                </ul>
            </div>

            <!-- Panel de herraminetas -->
            <div class="ml-3">
            <g:if test="${session.cliente}" >
            <!-- Panel para cliente identificados -->
                <div class="btn-group">

                    <g:link class="btn btn-primary" controller="carrito" action="index" ><i class="fas fa-shopping-cart mr-2"></i>(0)</span>
                        <div class="bg-white p-2 position-absolute d-none" style="z-index: 2;top:38px;left: 0px;" id="cajaPopUpProductos">
                            <div class="list-group"></div>
                        </div>
                    </g:link>

                    <g:if test="${session.cliente.rol}" >
                        <!-- Boton para administrador -->
                        <g:link controller="admin" class="btn btn-warning">
                            <i class="fas fa-tools mr-2"></i><g:message code="default.button.admin.panel.message" />
                        </g:link>
                    </g:if>

                    <!-- Menu herramientas cliente -->
                    <div class="dropdown">
                        <a class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <asset:image src="clientes/${session.cliente.imagen}" class="rounded" width="30px" />
                            ${session.cliente.nombre}
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <g:link controller="cliente" action="perfil" class="dropdown-item" >
                                <g:message code="default.button.cliente.perfil.message" />
                            </g:link>
                            <g:link controller="cliente" action="pedidos" class="dropdown-item">
                                <g:message code="default.button.cliente.pedidos.message" />
                            </g:link>
                            <g:link controller="cliente" action="login" class="dropdown-item">
                                <g:message code="default.button.cliente.relogin.message" />
                            </g:link>
                            <div class="dropdown-divider"></div>
                            <g:link controller="cliente" action="logout" class="dropdown-item">
                                <g:message code="default.button.cliente.cerrarSesion.message" />
                            </g:link>
                        </div>
                    </div>
                </div>
                </g:if>
                <g:else>
                <!-- Panel para cliente no identificados -->
                <div class="btn-group">
                    <g:link controller="cliente" action="login" class="btn btn-dark" >Iniciar sesión</g:link>
                    <g:link controller="cliente" action="registro" class="btn btn-primary" >Registrarse</g:link>
                </div>
                </g:else>
            </div>
        </nav>
    
    <g:layoutBody/>
</body>
</html>
