<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/index.css">
        <script src="<%=request.getContextPath()%>/js/password.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
        <title>Iniciar Sesión | Pollos Locos</title>
    </head>
    <body>
        <main class="container">
            <section class="row">
                <h1 class="text-center fw-bold">INICIAR SESIÓN</h1>

                <div class="icon my-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                    </svg>
                </div>

                <c:if test="${not empty param.mensajeError}">
                    <div id="mensajeError" class="alert alert-danger d-flex align-items-center justify-content-between">
                        ${param.mensajeError}
                        <button type="button" class="button-mensaje text-danger" onclick="cerrarMensaje()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/controlLogin" method="POST">

                    <div class="mb-3">
                        <label class="form-label fw-bold">Correo Electrónico: </label><br>
                        <input maxlength="80" class="form-control" type="email" name="email" value="@polloslocos.com" placeholder="Ingresa tu correo electrónico" required/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Contraseña: </label><br>

                        <div class="input-group">
                            <input maxlength="50" class="form-control" type="password" id="password" name="password" placeholder="Ingresa tu contraseña" required/>
                            <button type="button"
                                    id="togglePassword"
                                    onclick="mostrarPassword('password', 'togglePassword')"
                                    class="btn btn-outline-secondary">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-eye-off m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10.585 10.587a2 2 0 0 0 2.829 2.828" /><path d="M16.681 16.673a8.717 8.717 0 0 1 -4.681 1.327c-3.6 0 -6.6 -2 -9 -6c1.272 -2.12 2.712 -3.678 4.32 -4.674m2.86 -1.146a9.055 9.055 0 0 1 1.82 -.18c3.6 0 6.6 2 9 6c-.666 1.11 -1.379 2.067 -2.138 2.87" /><path d="M3 3l18 18" /></svg>
                            </button>
                        </div>                         
                    </div>
                    
                    <div class="text-center mt-4">
                        <input class="btn btn-primary" type="submit" value="Ingresar" />
                    </div>
                </form>
            </section>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script>
                                        const form = document.querySelector('form');
                                        const emailInput = document.querySelector('input[name="email"]');

                                        form.addEventListener('submit', function (event) {
                                            if (!emailInput.value.includes('@polloslocos.com')) {
                                                event.preventDefault();
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'Por favor ingresa un correo electrónico válido con el dominio @polloslocos.com',
                                                    confirmButtonColor: "#0A5ED7",
                                                    confirmButtonText: "Aceptar"
                                                });
                                            }
                                        });

                                        function cerrarMensaje() {
                                            let mensajeError = document.getElementById("mensajeError");
                                            mensajeError.style.display = "none";
                                            window.location.href = "${pageContext.request.contextPath}/index.jsp"
                                        }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>