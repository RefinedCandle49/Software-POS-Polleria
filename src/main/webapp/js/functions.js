function agregarAlCarrito(idProducto) {
    var URL = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    $.ajax({
        url: URL + '/controlCarrito?accion=AgregarCarrito',
        type: 'GET',
        data: {id: idProducto},
        success: function (data) {
            // Mostrar notificación en la esquina inferior derecha
            Toastify({
                text: 'Producto agregado exitosamente',
                duration: 1500, // Duración en milisegundos (2 segundos en este caso)
                close: true,
                gravity: 'bottom', // Cambiado a 'bottom' para ubicar en la esquina inferior
                position: 'right', // Cambiado a 'right' para ubicar en la esquina derecha
                backgroundColor: "#40a251", // Color de fondo
            }).showToast();
            console.log('Producto agregado exitosamente');
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error(textStatus, errorThrown);
            // Manejar el error, por ejemplo mostrando un mensaje al usuario
            // alert('Hubo un problema al agregar el producto al carrito.');
        }
    });
}

$(document).ready(function () {



    // function agregarAlCarrito(idProducto) {
    //     $.ajax({
    //         url: 'controlCarrito?accion=AgregarCarrito',
    //         type: 'GET',
    //         data: { id: idProducto },
    //         success: function(data) {
    //             // Actualizar la página con los cambios en el carrito
    //             // Por ejemplo, mostrar un mensaje de éxito o actualizar la cantidad de productos en el carrito
    //         },
    //         error: function(jqXHR, textStatus, errorThrown) {
    //             console.error(textStatus, errorThrown);
    //             // Manejar el error, por ejemplo mostrando un mensaje al usuario
    //         }
    //     });
    // }


    $('#buscar').click(function() {
        var documento = $('#documento').val();
        $.ajax({
            url: 'controlCarrito?accion=BuscarCliente',
            type: 'GET',
            data: { documento: documento },
            success: function(data) {
                console.log(data);

                try {
                    // Parsear el JSON recibido
                    var cliente = JSON.parse(data);

                    // Mostrar los datos en el DOM  
                    $('#nombreDisplay').val(cliente.nombre + ' ' + cliente.apellido);
                    $('#idCliente').val(cliente.idCliente);
                } catch (error) {
                    console.error(error);
                    $('#nombreDisplay').val('Cliente no encontrado');
                    $('#idCliente').val('');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error(textStatus, errorThrown);
                $('#nombreDisplay').val('Cliente no encontrado');
                $('#idCliente').val('');
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
