$(document).ready(function () {

    $('#buscar').click(function() {
        var idCliente = $('#idCliente').val();
        $.ajax({
            url: 'controlCarrito?accion=BuscarCliente',
            type: 'GET',
            data: { idCliente: idCliente },
            success: function(data) {
                console.log(data);

                try {
                    // Parsear el JSON recibido
                    var cliente = JSON.parse(data);

                    // Mostrar los datos en el DOM
                    $('#nombreDisplay').val(cliente.nombre + ' ' + cliente.apellido);
                } catch (error) {
                    console.error(error);
                    $('#nombreDisplay').val('Cliente no encontrado');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error(textStatus, errorThrown);
                $('#nombreDisplay').val('Cliente no encontrado');
            }
        });
    });

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
