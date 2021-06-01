<%@ page import="java.awt.Color; com.restaurantify.WebSettingsService" contentType="text/html;charset=UTF-8" %>
<%
    WebSettingsService settingsService = grailsApplication.classLoader.loadClass('com.restaurantify.WebSettingsService').newInstance()
    Map settings = settingsService.obtenerAjustes()
    Color c = Color.decode(settings.color as String)
    String color = "${c.getRed()},  ${c.getGreen()} , ${c.getBlue()}"
%>
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
        justify-content: ${settings.alignMenu}; !important;
    }

    .align-titulo {
        text-align: ${settings.alignTitulos}; !important;
    }

    :root {
        --acento-primario: rgb(${color});
        --acento-primario-sombra: rgba(${color}, 0.5);
        --acento-primario-transparente: rgba(${color}, 0.25);
    }

    </style>
    <script>
        const maxPlatosPedido = ${settings.maxPlatosPedido}
        const gastoEnvioDefault = ${settings.gastosDeEnvio}
        const pedidoSuperior = ${settings.gastosDeEnvioGratis}
    </script>
</head>
<body>
    <!-- Contenedor principal -->
    <div class="container-fluid p-0" style="min-height: 100vh;">

        <!-- Barra de navegación clientes -->
        <nav class="navbar navbar-expand-lg navbar-dark  bg-dark px-3 sticky-top">
            <!-- Logo página -->
            <div class="d-flex">
                <asset:image src="restaurante/${settings.imgLogotipo}" class="mr-2 d-lg-block d-none" alt="Logo web" width="50px" height="50px"/>
                <h1 class="mt-1 font-elegante">
                    <g:link class="text-light" uri="/">${settings.nombre}</g:link>
                </h1>
            </div>

            <button class="btn btn-primary navbar-toggler mr-2 text-white" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars py-1" style="font-size: 1.15em;"></i>
            </button>

            <!-- Menu navegación -->
            <div class="collapse navbar-collapse ml-lg-3 pb-lg-0 pb-2 menu" id="navbarNav">
                <div class="d-flex align-menu flex-grow-1">
                    <ul class="navbar-nav" style="font-size: 1.1em;">
                    <li class="nav-item ${request.forwardURI.matches("/") ? "active" : "" }">
                        <g:link class="nav-link d-inline-block" uri="/" >
                            <g:message code="default.title.inicio.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item ${request.forwardURI.matches("/plato/lista") ? "active" : "" }">
                        <g:link class="nav-link d-inline-block" controller="plato" action="lista" >
                            <g:message code="default.title.platos.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item ${request.forwardURI == "/cliente/contacto" ? "active" : "" }">
                        <g:link class="nav-link d-inline-block" controller="cliente" action="contacto" >
                            <g:message code="default.title.contacto.label"/>
                        </g:link>
                    </li>
                    <li class="nav-item ${request.forwardURI == "/inicio/ayuda" ? "active" : "" }">
                        <g:link class="nav-link d-inline-block" controller="inicio" action="ayuda" >
                            <g:message code="default.title.ayuda.label"/>
                        </g:link>
                    </li>
                    <g:if test="${[1, 2].contains(cliente?.rol)}" >
                        <li class="nav-item ${request.forwardURI.contains("pedidosRestaurante") ? "active" : "" }">
                            <g:link class="nav-link d-inline-block" controller="pedido" action="pedidosRestaurante">
                                <g:message code="default.button.pedidos.message"/>
                            </g:link>
                        </li>
                    </g:if>
                    <g:if test="${cliente?.rol == 1}" >
                    <li class="nav-item ${request.forwardURI.contains("admin") ? "active" : "" }">
                        <g:link class="nav-link d-inline-block" controller="admin" action="platos">
                            <g:message code="default.button.admin.panel.message"/>
                        </g:link>
                    </li>
                    </g:if>
                </ul>
                </div>

                <!-- Panel de herraminetas -->
                <div class="btn-toolbar ml-lg-3" role="toolbar">
                    <g:if test="${cliente}" >
                        <!-- Panel para cliente identificados -->
                        <div class="btn-group" role="group">
                            <g:link class="btn btn-primary" controller="cesta" role="button">
                                <i class="fas fa-shopping-cart mr-2"></i>
                                <span class="badge badge-dark" id="contadorCesta"></span>
                            </g:link>

                        <!-- Menu herramientas cliente -->
                            <div class="dropdown btn-group" role="group">
                                <button class="btn btn-primary dropdown-toggle" type="button" role="button" id="dropdownMenuLink"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asset:image src="clientes/${cliente?.imagen}" class="rounded" width="30px" />
                                    ${cliente?.nombre}
                                </button>
                                <div class="dropdown-menu  dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                                    <g:link controller="cliente" action="perfil" class="dropdown-item" role="button" >
                                        <g:message code="default.button.cliente.perfil.message" />
                                    </g:link>
                                    <g:link controller="pedido" action="misPedidos" class="dropdown-item" role="button">
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
            </div>
        </nav>
        <g:if test="${cliente?.verificado == false}">
        <div class="bg-primary text-whitex p-1 sticky-top" style="top: 76px;">
            <p class="text-white mb-0 text-center">
                <g:message code="defaul.cliente.noVerificado.message" args="${[cliente?.email]}" />
            </p>
        </div>
        </g:if>

    <div class="modal fade" id="alertaModal" tabindex="-1" role="dialog" aria-labelledby="alertaModalTitle" aria-hidden="true"></div>

    <g:layoutBody/>
</body>
</html>
