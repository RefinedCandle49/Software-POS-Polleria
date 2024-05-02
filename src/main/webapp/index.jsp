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
                        <input type="email" name="email" required/>
                    </div>
                    
                    <div>
                        <label>Contraseña: </label><br>
                        <input type="password" name="password" required/>
                    </div>
                    
                    <br>
                    
                    <input type="submit" value="Ingresar" />
                
                </form>
            </section>
        </main>
    </body>
</html>