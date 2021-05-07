</main>

<!-- Pie de página --->
<nav class="bg-light border text-center p-3">
    <h2>Pie de pagina</h2>
</nav>

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

<g:javascript>
    // Modal para imagen
    $(function() {
        $('.pop').on('click', function() {
            $('.imagepreview').attr('src', $(this).find('img').prevObject.attr('src'));
            $('#imagemodal').modal('show');
        });
    });
</g:javascript>