<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="cabecera">
    <title><g:message code="default.title.platos.label" /></title>
</head>
<body>

<main class="row" style="min-height: 100vh">
    <article class="col-3">
        <g:applyLayout name="filtrosPlatos" />
    </article>

    <!-- Contenedor datos genericos --->
    <section class="col-9 p-2 bg-white">
        <!-- Listado con los platos -->
        <g:each in="${categoriasConPlatos}" var="c" status="i">
        <div id="accordion${i}">
            <div class="card">
                <div class="card-header bg-dark" id="heading${i}">
                    <h5 class="mb-0">
                        <button class="btn btn-link text-white" data-toggle="collapse" data-target="#collapse${i}"
                                aria-expanded="true" aria-controls="collapse${i}">
                            <h4>${c.nombre}</h4>
                        </button>
                    </h5>
                </div>

                <div id="collapse${i}" class="collapse show" aria-labelledby="heading${i}" data-parent="#accordion${i}">
                    <div class="card-body">
                        <div class="list-group">
                        <g:each in="${c.platos}" var="p" >
                            <div class="d-flex align-items-center list-group-item list-group-item-action">
                                <asset:image class="border mr-3 pop" src="platos/${p.imagen}" width="80px" height="auto" />
                                <g:link class="btn btn-link" action="show" id="${p.id}"><h5>${p.nombre}</h5></g:link>
                                <h5>${p.total}€</h5>
                            </div>
                        </g:each>
                        </div>
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