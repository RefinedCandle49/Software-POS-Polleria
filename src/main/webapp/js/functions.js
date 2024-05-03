$(document).ready(function () {

    // $("tr #btnDetele").click(function () {
    //     var idp = $(this).parent().find('#id').val();
    //     eliminar(idp);
    // });
    //
    // function eliminar(idp) {
    //     var url = "controlCarrito?accion=Delete";
    //     // console.log(idp);
    //     $.ajax({
    //         type: 'POST',
    //         url: url,
    //         data: "idp=" + idp,
    //         success: function (data, textStatus, jqXHR) {
    //         }
    //     });
    // }

    $("tr #Cantidad").on("input", function (e) {
        var idp = $(this).parent().find('#id').val();
        var cantidad = $(this).val();
        var url = "controlCarrito?accion=ActualizarCantidad";
        console.log(idp, cantidad);
        $.ajax({
            type: 'POST',
            url: url,
            data: {
                id: idp,
                cantidad: cantidad
            },
            success: function (data, textStatus, jqXHR) {
                parent.location.href = "controlCarrito?accion=Carrito";
            }
        });
    });

});
