/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function alertBienvenida() {
    const url = new URLSearchParams(window.location.search);
    const peru = url.get('peru');

    if (peru === 'false') {
        Swal.fire({
            title: 'Bienvenido, ' + nombreRol
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = contextPath + "/admin/usuarios.jsp?peru=true";
            }
        });
    }
}

