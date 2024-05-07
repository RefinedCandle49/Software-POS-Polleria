<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión | Pollos Locos</title>
    </head>
    <body>
        <main>
            <section>
                <h1>Inicia Sesión</h1>
                <form action="${pageContext.request.contextPath}/controlLogin" method="POST">
                    
                    <div>
                        <label>Correo Electrónico: </label><br>
                        <input maxlength="80" type="email" name="email" value="@polloslocos.com" placeholder="Ingresa tu correo electrónico" required/>
                        
                    </div>
                    
                    <div>
                        <label>Contraseña: </label><br>
                        <input maxlength="50" type="password" name="password" placeholder="Ingresa tu contraseña" required/>
                    </div>
                    
                    <br>
                    
                    <input type="submit" value="Ingresar" />
                
                </form>
            </section>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script>
            const form = document.querySelector('form');
            const emailInput = document.querySelector('input[name="email"]');

            form.addEventListener('submit', function(event) {
                if (!emailInput.value.includes('@polloslocos.com')) {
                    event.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Por favor ingresa un correo electrónico válido con el dominio @polloslocos.com'
                    });
                }
            });
        </script>
    </body>
</html>