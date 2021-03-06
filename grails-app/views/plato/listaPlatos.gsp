<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.platos.label" /></title>
</head>
<body>

<main class="d-flex flex-wrap mx-xl-5" style="min-height: 100vh">
    <article class="col-lg-3 col-md-12">
        <g:applyLayout name="filtrosPlatos" />
    </article>

    <!-- Contenedor datos genericos --->
    <section class="col-lg-9 col-md-12 p-2 bg-white">
        <!-- Listado con los platos -->
        <g:each in="${categoriasConPlatos}" var="c" status="i">
        <div id="accordion${i}">
            <div class="card">
                <div class="card-header bg-dark" id="heading${i}">
                    <h5 class="mb-0">
                        <button class="btn btn-link text-white text-decoration-none" data-toggle="collapse" data-target="#collapse${i}"
                                aria-expanded="true" aria-controls="collapse${i}">
                            <h2 class="font-elegante">${c.nombre}</h2>
                        </button>
                    </h5>
                </div>

                <div id="collapse${i}" class="collapse show" aria-labelledby="heading${i}" data-parent="#accordion${i}">
                    <div class="ml-2">
                        <g:each in="${c.platos}" var="p" >
                                <div class="d-flex align-items-center border-bottom py-3 px-2 mb-1">
                                    <g:link class="btn-link" action="show" id="${p.id}">
                                    <asset:image class="border mr-3" src="platos/${p.imagen}" width="100px" height="80px" />
                                    <div class="d-flex flex-column">
                                        <g:link class="btn-link mr-2" action="show" id="${p.id}"><h4>${p.nombre}</h4></g:link>
                                        <h5>
                                            <span class="badge badge-primary">${p.total} €</span>
                                        </h5>
                                    </div>
                                    </g:link>
                                </div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
        </g:each>
    </section>
</main>

<g:applyLayout name="pie" />
<g:javascript>
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
</g:javascript>
</body>
</html>