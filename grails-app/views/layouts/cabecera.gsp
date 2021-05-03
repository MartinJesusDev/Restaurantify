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
    <div class="container-fluid min-vh-100 p-0">

        <!-- Barra de navegación clientes -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white px-3">
            <!-- Logo página -->
            <div class="d-flex">
                <asset:image src="restaurante/logotipo.jpg" class="mr-1" alt="Logo web" width="50px" height="50px"/>
                <h1>
                    <g:link class="text-dark" uri="/">Restaurantify</g:link>
                </h1>
            </div>

            <div class="ml-3 align-menu w-100">
            <g:if test="${session.cliente}" >
            <!-- Panel para cliente identificados -->
                <div class="btn-group">
                    <div>
                        <a class="btn btn-primary" id="enlaceCarrito" href="carrito"><i class="fas fa-shopping-cart"></i>Carrito<span class="p-1" id="contadorArticulos">(0)</span>
                            <div class="bg-white p-2 position-absolute d-none" style="z-index: 2;top:38px;left: 0px;" id="cajaPopUpProductos">
                                <div class="list-group"></div>
                            </div>
                        </a>

                    </div>

                    <g:if test="${session.cliente.rol == 1}" >
                        <!-- Boton para administrador -->
                        <a class="btn btn-warning" href="admin"><i class="fa fa-tools pr-2"></i>Admin panel</a>
                    </g:if>

                    <!-- Menu herramientas cliente -->
                    <div class="dropdown">
                        <a class="btn btn-dark dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-user pr-2"></i>${session.cliente.nombre}
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <g:link controller="cliente" action="perfil" class="dropdown-item">
                                <g:message code="default.button.cliente.perfil.message" />
                            </g:link>
                            <g:link controller="cliente" action="pedidos" class="dropdown-item">
                                <g:message code="default.button.cliente.pedidos.message" />
                            </g:link>
                            <g:link controller="cliente" action="login" class="dropdown-item">
                                <g:message code="default.button.cliente.relogin.message" />
                            </g:link>
                            <g:link controller="cliente" action="logout" class="dropdown-item">
                                <g:message code="default.button.cliente.cerrarSesion.message" />
                            </g:link>
                        </div>
                    </div>
                    <g:link controller="cliente" action="logout" class="btn btn-danger">
                        <g:message code="default.button.cliente.cerrarSesion.message" />
                    </g:link>
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

        <!-- Contenido de la página --->
        <main>
    <g:layoutBody/>
</body>
</html>
