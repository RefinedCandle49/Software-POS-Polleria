/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function DominioPorDefecto() {
    let emailVar = document.getElementById('email');
    let domain = '@polloslocos.com';
        
    emailVar.value = domain;
    emailVar.addEventListener('input', function(event) {
        var inputVar = event.target.value;
        if (!inputVar.endsWith(domain)) {
            event.target.value = domain;
        }
    });
};
