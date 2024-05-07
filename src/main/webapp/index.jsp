<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión | Pollos Locos</title>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/index.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <main class="container">
            <section class="row">
                <h1 class="text-center">Inicia Sesión</h1>

                <c:if test="${not empty mensajeError}">
                    <div>
                        <c:out value="${mensajeError}" />
                    </div>
                </c:if>
                <div class="icon">
			<svg xmlns="http://www.w3.org/2000/svg" width="60" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
			  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
			  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
			</svg>
		    </div>
                <form action="${pageContext.request.contextPath}/controlLogin" method="POST">

                    <div class="mb-3">
                        <label class="form-label">Correo Electrónico: </label><br>
                        <input maxlength="80" class="form-control" type="email" name="email" value="@polloslocos.com" placeholder="Ingresa tu correo electrónico" required/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Contraseña: </label><br>
                        <input maxlength="150" class="form-control" type="password" name="password" placeholder="Ingresa tu contraseña" required/>
                    </div>

                    <br>
                <div class="text-center">
                    <input class="btn btn-dark" type="submit" value="Ingresar" />
                </div>
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
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>