<!-- Barra lateral filtro de platos -->
<nav class="nav border rounded p-2 mt-2  bg-light position-sticky" style="top: 80px;">
    <div class="row">
        <div class="col">
            <h2 class="font-titulo">Filtrado</h2>
        </div>
    </div>

    <div>
        <!-- Formulario de filtros -->
        <g:form class="form"  controller="plato"  action="lista">
            <div class="form-row">
                <div class="form-group col">
                    <label for="categorias"><g:message code="default.input.filtrar.categorias.label"/></label>
                    <g:select class="custom-select" name="categorias" optionKey="id" optionValue="nombre" from="${listadoCategorias}"
                              multiple="multiple" value="${filtro?.categorias?.id}" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="alergenos"><g:message code="default.input.filtrar.alergenos.label"/></label>
                    <g:select class="custom-select" name="alergenos" optionKey="id" optionValue="nombre" from="${listadoAlergenos}"
                          multiple="multiple" value="${filtro?.alergenos?.id}" />
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="precioMin"><g:message code="default.input.filtrar.precioMin.label"/></label>
                    <g:textField type="number" step="0.01" class="form-control" min="0" name="precioMin"
                             value="${fieldValue(bean: filtro, field: "precioMin")}"/>
                </div>

                <div class="form-group col">
                    <label for="precioMax"><g:message code="default.input.filtrar.precioMax.label"/></label>
                    <g:textField type="number" step="0.01" class="form-control" name="precioMax"
                             value="${fieldValue(bean: filtro, field: "precioMax")}"/>
                </div>
            </div>

            <div class="form-group" >
                <g:actionSubmit class="btn btn-primary" action="lista"
                                value="${message(code: "default.button.platos.filtrar.message")}" />
            </div>
        </g:form>
    </div>
</nav>
