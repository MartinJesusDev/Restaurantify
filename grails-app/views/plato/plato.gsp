<%@ page contentType="text/html;charset=UTF-8" %>
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
    <section class="col p-2 bg-white mt-3">
        <!-- Información del plato y agregar a cestra -->
        <article class="d-flex" style="margin-bottom: 100px;">
            <!-- Imagen plato -->
            <div class="col-lg-5 d-flex d-none justify-content-center align-items-center">
                <asset:image src="platos/${p.imagen}" style="width: 90%;height: 90%"/>
            </div>

            <div class="col-lg-6 ml-lg-5">
        <!-- Info plato -->
        <div class="col-10 text-justify mb-4">
            <h1 class="mb-3">${p.nombre}</h1>
            <p>${p.elaboracion}</p>
        </div>

        <!-- Información de alergenos -->
        <div class="col mb-4">
            <h5><g:message code="default.title.alergenos.label" /> </h5>
            <div class="d-flex">
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
            <div class="border-top border-bottom pt-3 pb-2 mb-3">
                <h5><g:message code="default.input.precio.label" /> ${p.precio}€
                    <g:if test ="${p.descuento}">
                        <span class="ml-2 badge badge-warning">
                            <g:message code="default.input.plato.descuento.label" />
                            ${p.descuento.round()}%
                        </span>
                    </g:if>
                </h5>
                <small>(<g:message code="default.input.plato.ivaAplicado.label"/>: ${p.iva.round()}%)</small>
            </div>

            <g:form controller="cesta">
                <g:hiddenField name="plato" value="${p.id}" />

                <b><label for="unidades"><g:message code="default.input.cesta.unidades.label"/> </label></b>
                <div class="form-row">
                    <div class="form-group">
                        <g:field class="form-control" min="1" max="10" type="number" name="unidades" value="1" />
                    </div>
                    <div class="form-group">
                        <g:actionSubmit class="btn btn-primary" action="agregar"
                                        value="${message(code: 'default.button.cesta.agregar.message')}" />
                    </div>
                </div>
            </g:form>
        </div>
    </div>
        </article>

        <!-- Valoraciones del platos --->
        <article class="d-flex flex-row flex-wrap">
            <div class="col-lg-4 col-12 ml-lg-2">
            <!-- Titulo y valoraciones totales -->
                <div class="col mb-4">
                    <h2 class="mb-3"><g:message code="default.input.valoracion.general.label" /></h2>
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
                            <div class="ml-0 errors rounded" role="alert"><li><g:message code="${flash.valoracionMessage}" /></li></div>
                        </g:if>
                        <g:else>
                            <div class="ml-0 message rounded" role="status"><g:message code="${flash.valoracionMessage}" /></div>
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
                                <g:actionSubmit action="eliminar" class="btn btn-danger" value="${message(code: 'default.button.valoracion.eliminar.message')}" />
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

            <!-- Lista de valoraciones -->
            <g:if test="${valoraciones.total > 0}">
            <div class="col-lg-7 col-12 ml-lg-5">
                <h2 class="mb-4"><g:message code="default.input.valoraciones.label" /></h2>
                <g:each in="${valoraciones.lista}" var="v" status="i">
                    <div class="card mb-3">
                            <div class="card-header p-2 d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <asset:image class="mr-2 rounded" src="clientes/${v.cliente.imagen}" width="40px"/>
                                    <h5>${v.cliente.nombre} ${v.cliente.apellidos}</h5>
                                </div>
                                <div >
                                    <small class="mb-0 text-info"><g:message code="default.input.valoraciones.fecha.label"/> ${v.fecha}</small>
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
                        <tb:paginate class="mx-0 justify-content-center" controller="plato" action="show" params="${[id: p.id]}" total="${valoraciones.total}"/>
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
    // Select2 desplegable
    $(document).ready(
        $("#alergenos, #categorias").each(function() {
            // Agregando select 2
            $(this.tagName).select2({
                closeOnSelect: false,
                allowClear: true,
                placeholder: "${message(code: 'default.input.select2.label')}"
            });

            // Agregando checkbox

        }));

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