/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function alertBienvenida() {
    const url = new URLSearchParams(window.location.search);
    const alert = url.get('alert');

    if (alert === 'true') {
        Swal.fire({
            icon: "success",
            title: 'Bienvenido, ' + nombreRol,
            confirmButtonColor: "#0A5ED7",
            confirmButtonText: "Aceptar",
            allowOutsideClick: false
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = contextPath + "/admin/usuarios.jsp?alert=false";
            }
        });
    }
}

