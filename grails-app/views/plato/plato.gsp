<%@ page import="com.restaurantify.WebSettingsService" contentType="text/html;charset=UTF-8" %>
<%
    WebSettingsService settingsService = grailsApplication.classLoader.loadClass('com.restaurantify.WebSettingsService').newInstance()
    Map settings = settingsService.obtenerAjustes()
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <g:set var="p" value="${plato}" />
    <title>${p.nombre}</title>

    <!-- Cargamos el selector de estrellas -->
    <asset:javascript src="star.js" />
</head>
<body>
    <!-- Vista de plato --->
    <section class="col px-0 p-2 bg-white mt-3">
        <!-- Información del plato y agregar a cestra -->
        <article class="d-flex mx-xl-5" style="margin-bottom: 100px;">
            <!-- Imagen plato -->
            <div class="col-lg-5 d-none d-md-flex justify-content-center align-items-stretch" style="min-height: auto; max-height: 550px;">
                    <asset:image class="img-fluid d-lg-none d-lg-flex" src="platos/${p.imagen}" />
            </div>

            <div class="col-lg-6 ml-xl-5">
        <!-- Info plato -->
        <div class="col mb-4">
            <h2 class="mb-3 font-titulo">${p.nombre}</h2>
                <div class="col-12 p-0">
                    <p class="text-justify" style="font-size: 1.1em;">${p.elaboracion}</p>
                </div>

                <div class="col d-flex d-sm-none justify-content-center align-items-stretch" style="min-height: 100px;">
                    <asset:image class="img-fluid d-sm-none d-sm-flex" src="platos/${p.imagen}" />
                </div>
        </div>

        <!-- Información de alergenos -->
        <div class="col mb-3">
            <h4><g:message code="default.title.alergenos.label" /> </h4>
            <div class="d-flex flex-wrap">
                <g:if test="${p.alergenos.empty}">
                    <p class="mb-0"><g:message code="default.alergeno.sin.alergenos.message" /></p>
                </g:if>
                <g:each in="${p.alergenos}" var="a" >
                    <figure class="card mr-2">
                        <div class="card-body p-2 d-flex flex-column align-items-center">
                            <asset:image src="alergenos/${a.imagen}" width="50px" />
                            <figcaption>${a.nombre}</figcaption>
                        </div>
                    </figure>
                </g:each>
            </div>
        </div>

        <!-- Precio y formulario pedido -->
        <div class="col">
            <div class="pb-2 mb-3">
                <h4><g:message code="default.input.precio.label"/></h4>
                <h5><span style="font-size: 1.5em;">${p.total} €</span>
                    <g:if test ="${p.descuento}">
                        <span class="badge badge-primary ml-2">
                        <g:message code="default.input.plato.descuento.label" />
                        ${p.descuento.round()}%
                        </span>
                    </g:if>
                </h5>
                <small><g:message code="default.input.plato.ivaAplicado.label"/>: ${p.iva.round()}%</small>
            </div>

            <g:form controller="cesta">
                <g:hiddenField name="plato" value="${p.id}" />
                <h4><label for="unidades"><g:message code="default.input.cesta.unidades.label"/> </label></h4>
                <div class="form-row">
                    <div class="form-group">
                        <g:select class="custom-select" name="unidades" from="${1..settings.maxPlatosPedido}" style="width: 100px;" />
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary" type="button"
                                onclick="agregar(${session?.cliente?.id ?: -1}, ${p.id}, unidades.value);" >
                            <g:message code="default.button.cesta.agregar.message"/>
                        </button>
                    </div>
                </div>

                <!-- Div que muestra resultado -->
                <div id="resultado"></div>
            </g:form>
        </div>
    </div>
        </article>

        <!-- Valoraciones del platos --->
        <article class="d-flex mx-xl-5 flex-row flex-wrap justify-content-between">
            <div class="col-lg-4 col-12 ml-lg-2 mb-5">
                <div class="position-sticky" style="top: 100px;">
                    <!-- Titulo y valoraciones totales -->
                    <div class="col mb-4">
                        <h3 class="mb-3 font-titulo"><g:message code="default.input.valoracion.general.label" /></h3>
                        <div class="mb-2">
                            <div class="d-flex align-items-center">
                                <div class="starRatingContainer"><div class="update1.2"></div></div>
                                <span class="ml-2"><h5 class="mb-0"><g:message code="default.input.valoraciones.final.label" args="[valoraciones.pf.trunc(1)]" /></h5></span>
                            </div>
                        </div>
                        <g:if test="${valoraciones.total > 0}">
                            <p><g:message code="default.input.valoraciones.totales.label" args="[valoraciones.total]"/></p>
                        </g:if>
                        <g:else>
                            <p><g:message code="default.input.valoraciones.sinValorar.label"/></p>
                        </g:else>
                        <hr>
                    </div>

                    <!-- Valoraciones -->
                    <div class="col">
                    <h4><g:message code="default.input.valoracionCliente.label"/> </h4>
                    <g:if test="${session?.cliente?.verificado}" >
                        <!-- Mensaje informativo plato --->
                        <g:if test="${flash?.valoracionMessage}">
                            <g:if test="${flash.error}" >
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <g:message code="${flash?.valoracionMessage}" />
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </g:if>
                            <g:else>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <g:message code="${flash?.valoracionMessage}" />
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </g:else>
                        </g:if>

                        <!-- Formulario de valoración -->
                        <g:form  controller="valoracion" >
                            <g:hiddenField name="puntuacion" value="${fieldValue(bean: valoracion, field: "puntuacion") ?: miValoracion?.puntuacion ?: 5}" />
                            <g:hiddenField name="idPlato" value="${p.id}" />
                            <g:hiddenField name="idValoracion" value="${miValoracion?.id}" />
                            <div class="form-group">
                                <div>
                                    <label class="col-form-label"><g:message code="default.input.valoracion.puntuacion.label"/>:
                                        <span class="ratingHolder">${valoracion?.puntuacion ?: miValoracion?.puntuacion ?: 5}</span>
                                    </label>
                                    <div class="starRatingContainer"><div class="starValoration"></div></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="comentario" class="col-form-label"><g:message code="default.input.valoraciones.opinion.label"/> </label>
                                <g:textArea name="comentario" class="form-control" rows="4" value="${fieldValue(bean: valoracion, field: "comentario") ?: miValoracion?.comentario}"/>
                            </div>
                            <div class="form-group">
                                <g:if test="${!miValoracion}" >
                                    <g:actionSubmit action="crear" class="btn btn-primary" value="${message(code: 'default.button.valoracion.guardar.message')}" />
                                </g:if>
                                <g:else>
                                    <g:actionSubmit action="actualizar" class="btn btn-primary" value="${message(code: 'default.button.valoracion.actualizar.message')}" />
                                    <g:actionSubmit action="eliminar" class="btn btn-danger" onclick="return confirm('${message(code: "default.valoracion.confirmarEliminar.message")}')" value="${message(code: 'default.button.valoracion.eliminar.message')}" />
                                </g:else>
                            </div>
                        </g:form>
                    </g:if>
                    <g:elseif test="${session.cliente && !session?.cliente?.verificado}">
                        <p><g:message code="default.input.valoracion.verificarCorreo.label" /></p>
                    </g:elseif>
                    <g:else>
                        <p><g:message code="default.input.valoracion.inicieSession.label" /></p>
                    </g:else>
                    </div>
                </div>
            </div>

            <!-- Lista de valoraciones -->
            <g:if test="${valoraciones.total > 0}">
            <div class="col-lg-7 col-12 ml-lg-5">
                <h3 class="mb-4 font-titulo"><g:message code="default.input.valoraciones.label" /></h3>
                <!-- Mensaje informativo plato --->
                <g:if test="${flash?.valoracionCliente}">
                    <g:if test="${flash.error}" >
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <g:message code="${flash?.valoracionCliente}" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <g:message code="${flash?.valoracionCliente}" />
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </g:else>
                </g:if>

                <g:each in="${valoraciones.lista}" var="v" status="i">
                    <div class="card mb-3">
                            <div class="card-header bg-dark text-white p-2 d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <asset:image class="mr-2 rounded" src="clientes/${v.cliente.imagen}" width="40px"/>
                                    <h5>${v.cliente.nombre} ${v.cliente.apellidos}</h5>
                                </div>
                                <div class="mr-2" >
                                    ${v.fecha}
                                    <g:if test="${session?.cliente?.rol == 1}">
                                        <g:link class="btn btn-danger ml-2" controller="valoracion" action="eliminarAdmin" params="[id: v.id]"  onclick="return confirm('¿Seguro que desea borrar la valoración?')"><i class="fas fa-trash"></i></g:link>
                                    </g:if>
                                </div>
                            </div>
                            <div class="card-body p-3">
                                <div class="starRatingContainer mb-2"><div class="oc${i}"></div></div>
                                <p class="text-justify">${v.comentario}</p>
                            </div>
                    </div>
                    <g:javascript>
                    (function(){
                    // Propiedades para selector de puntuación
                    let imgStar = "${assetPath(src: "star.png")}"
                    let imgStarBackground = "${assetPath(src: "backgroundStar.png")}"
                    let properties2 = [
                        {"rating":"${v.puntuacion}", "maxRating":"5", "minRating":"1", "readOnly":"yes", "starImage": imgStar, "backgroundStarImage": imgStarBackground, "starSize":"18", "step":"1"}
                    ];

                        try {rateSystem("oc${i}", [properties2[0]])} catch (e) {}}())
                    </g:javascript>
                </g:each>

                <g:if test="${valoraciones.total > valoraciones.lista.size()}">
                    <!-- Paginación -->
                    <nav class="mt-5" aria-label="Paginación de valoraciones">
                        <tb:paginate class="mx-0 justify-content-center" controller="plato" action="show" params="${[id: p.id]}" total="${valoraciones.total}" prev="&laquo;" next="&raquo;"/>
                    </nav>
                </g:if>
            </g:if>
            <g:else>
                <div class="col-lg-7 col-12 ml-lg-5">
                    <h2 class="mb-4"><g:message code="default.input.valoraciones.label" /></h2>
                    <p class="ml-2"><g:message code="default.input.valoraciones.sinOpiniones.label"/></p>
                </div>
            </g:else>
            </div>
        </article>
    </section>

<g:applyLayout name="pie" />
<g:javascript>
    (function(){
    // Propiedades para selector de puntuación
    let imgStar = "${assetPath(src: "star.png")}"
    let imgStarBackground = "${assetPath(src: "backgroundStar.png")}"
    let properties2 = [
        {"rating":"${miValoracion?.puntuacion ?: valoracion?.puntuacion ?: 5}", "maxRating":"5", "minRating":"1", "readOnly":"no", "starImage": imgStar, "backgroundStarImage": imgStarBackground, "starSize":"30", "step":"1"},
        {"rating":"${valoraciones.pf}", "maxRating":"5", "minRating":"0", "readOnly":"yes", "starImage": imgStar, "backgroundStarImage": imgStarBackground, "starSize":"36", "step":"1"}
    ];

    try {
        // Codigo de puntuación del plato
        rateSystem("update1.2", [properties2[1]])

        // Código de selector de puntuación
        rateSystem("starValoration", [properties2[0]],
        function(rating, ratingTargetElement, isTouchScreen){
            rating = Math.trunc(rating)
            document.getElementById("puntuacion").value = rating;
            ratingTargetElement.parentElement.parentElement.getElementsByClassName("ratingHolder")[0].innerHTML = rating;
        })
    } catch (e) {}

    }())
</g:javascript>

</body>
</html>
