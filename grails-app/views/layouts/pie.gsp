<%@ page import="java.awt.Color; com.restaurantify.WebSettingsService" contentType="text/html;charset=UTF-8" %>
<%
    WebSettingsService settingsService = grailsApplication.classLoader.loadClass('com.restaurantify.WebSettingsService').newInstance()
    Map settings = settingsService.obtenerAjustes()
    Color c = Color.decode(settings.color as String)
    String color = "${c.getRed()},  ${c.getGreen()} , ${c.getBlue()}"
%>
<!-- Pie de página --->
    <!-- Pie de página -->
<footer id="pie-pagina" class="dark">
    <!-- Columna info página -->
    <section class="info">
        <!-- Logo página -->
        <div class="d-flex">
            <asset:image src="restaurante/${settings?.imgLogotipo}" class="mr-2 d-lg-block d-none" alt="Logo web" width="40px" height="40px"/>
            <h2 class="mt-1 font-elegante">${settings?.nombre}</h2>
        </div>
        <ul class="list-unstyled">
            <li>C/ Belén, n2, 2360</li>
            <li>Alcalá la Real, Jaén</li>
            <li><g:message code="default.input.pie.tel.message"/>: 943 220 310</li>
            <li><g:message code="default.input.pie.mail.message"/>: contacto@servidor.edu</li>
            <li>
                <p><g:message code="default.input.pie.horario.message"/>: Lun a Vie 9.30 a 14.30 y 16.30 a 20:00</p>
            </li>
        </ul>
    </section>

    <!-- Columna mapa página -->
    <section class="mapa">
        <ul>
            <li class="${request.forwardURI.matches("/") ? "active" : "" }">
                <g:link class="btn-link mb-3" uri="/" >
                    <g:message code="default.title.inicio.label"/>
                </g:link>
            </li>
            <li class="${request.forwardURI.matches("/plato/lista") ? "active" : "" }">
                <g:link class="btn-link mb-3" controller="plato" action="lista" >
                    <g:message code="default.title.platos.label"/>
                </g:link>
            </li>
            <li class="${request.forwardURI == "/cliente/contacto" ? "active" : "" }">
                <g:link class="btn-link mb-3" controller="cliente" action="contacto" >
                    <g:message code="default.title.contacto.label"/>
                </g:link>
            </li>
            <li class="${request.forwardURI == "/inicio/ayuda" ? "active" : "" }">
                <g:link class="btn-link mb-3" controller="inicio" action="ayuda" >
                    <g:message code="default.title.ayuda.label"/>
                </g:link>
            </li>
        </ul>
    </section>

    <!-- Columna redes sociales -->
    <section class="redes">
        <div>
            <a href="https://www.instagram.com/" target="_blank">
                <i class="icono fab fa-instagram"></i><span>Instagram</span></a>
        </div>
        <div>
            <a href="https://www.facebook.com" target="_blank">
                <i class="icono fab fa-facebook"></i><span>Facebook</span></a>
        </div>
        <div>
            <a href="https://twitter.com" target="_blank">
                <i class="icono fab fa-twitter"></i><span>Twitter</span></a>
        </div>
    </section>

    <!-- Columna políticas, desarrollo -->
    <section class="dev">
        <p><g:link controller="inicio" action="politicas"><g:message code="default.input.pie.politicas.message"/></g:link></p>
        <p><a href="mailto:martinjesusmanasrivas@gmail.com"><g:message code="default.input.pie.design.message"/>: Martín Mañas</a></p>
    </section>
</footer>

<!-- Modal para mostrar la imagen del plato -->
<div class="modal fade" id="imagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <img src="" class="imagepreview" style="width: 100%;" >
            </div>
        </div>
    </div>
</div>

<!-- Dependencias de la aplicación -->
<asset:javascript src="application.js" />

<g:if test="${session?.cliente}" >
    <!-- Cargamos la cesta del cliente -->
    <g:javascript>cargarCesta()</g:javascript>
</g:if>

<g:javascript>
    // Modal para imagen
    $(function() {
        $('.pop').on('click', function() {
            $('.imagepreview').attr('src', $(this).find('img').prevObject.attr('src'));
            $('#imagemodal').modal('show');
        });
    });
</g:javascript>