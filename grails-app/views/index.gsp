<%@ page contentType="text/html;charset=UTF-8" %>tarta de la abuela
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title>Restaurante</title>
</head>
<body>
<!-- Pagina -->
<section class="px-0 pt-4 bg-white">
    <div class="d-flex flex-wrap mb-4 justify-content-center mb-3">
        <div class="col-md-10 col-12 p-0 mb-4">
            <!-- Carousel principal -->
            <div id="carouselPlatos" class="carousel slide rounded bg-dark" data-ride="carousel">
                <div class="carousel-inner">
                    <g:each in="${listaPlatos}" var="p" status="i" >
                        <div class="carousel-item ${i == 0 ? "active" : ""}">
                            <asset:image class="d-block" src="platos/${p.imagen}" alt="${p.nombre}" />
                            <div class="carousel-caption d-none d-md-block">
                                <h2 class="font-elegante">${p.nombre}</h2>
                            </div>
                        </div>
                    </g:each>
                </div>
                <a class="carousel-control-prev" href="#carouselPlatos" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselPlatos" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="row mt-3 justify-content-center d-md-flex d-none">
                    <a class="btn btn-primary btn-lg" href="#carta"><i class="fas fa-chevron-down"></i> </a>
            </div>
        </div>
    </div>

    <!-- Tarjeta del restaurante carta -->
    <div class="col-12 p-xl-0 p-md-3 mb-md-0 mb-5 d-flex flex-wrap tarjeta" id="carta">
        <div class="col-md-6 p-0 col-12 d-flex justify-content-center align-items-center">
            <div class="contenido">
                <h2 class="font-titulo"><g:message code="default.input.inicio.tarjeta.nuestraCarta.title"/></h2>
                <p><g:message code="default.input.inicio.tarjeta.nuestraCarta.message"/></p>
                <g:link controller="plato" action="lista" class="btn btn-primary btn-lg"><g:message code="default.button.inicio.nuestraCarta.verCarpta"/></g:link>
            </div>
        </div>
        <div class="col-md-6 p-0">
            <asset:image class="" src="restaurante/platos-restaurante-portada.jpg" />
        </div>
    </div>

    <!-- Tarjeta restaurante contacto -->
    <div class="col-12 p-xl-0 p-md-3 mb-5 d-flex flex-wrap flex-row-reverse tarjeta">
        <div class="col-md-6 p-0 col-12 d-flex justify-content-center align-items-center">
            <div class="contenido">
                <h2 class="font-titulo"><g:message code="default.input.inicio.tarjeta.reserva.title"/></h2>
                <p><g:message code="default.input.inicio.tarjeta.reserva.message"/></p>
                <g:link controller="cliente" action="contacto" class="btn btn-primary btn-lg"><g:message code="default.button.inicio.reserva.contacto"/></g:link>
            </div>
        </div>
        <div class="col-md-6 p-0 d-flex justify-content-end">
            <asset:image class="" src="restaurante/foto-restaurante.jpg" />
        </div>
    </div>
</section>

<g:applyLayout name="pie" />
</body>
</html>