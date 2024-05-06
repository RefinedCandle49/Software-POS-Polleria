/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function mostrarPassword(idInput, idButton) {
    let password = document.getElementById(idInput);
    let button = document.getElementById(idButton);
    
    if (password.type === "password"){
        password.type = "text";
        button.textContent = "Ocultar";
    } else {
        password.type = "password";
        button.textContent = "Mostrar";
    }
}