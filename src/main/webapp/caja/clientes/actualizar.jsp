<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Cliente, model.Usuario, conexion.Conexion, dao.ClienteDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
                        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
                        <title>Actualizar | Cliente</title>
                        </head>
                        <body class="container-fluid p-0">

                            <%
                                HttpSession sesion = request.getSession(false);
            
                                if (sesion == null || sesion.getAttribute("usuario") == null) {
                                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                                    return;
                                }
            
                                String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
                                if(!"Cajero".equals(nombreRol)){    
                            %>
                            <script>
                                alert("Acceso Denegado");
                                <%
                                switch(nombreRol){
                                    case "Administrador":
                                %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp?page=1";<%
                                        break;
                    
                                    case "Almacenero":
                                %>window.location.href = "<%= request.getContextPath() %>/almacen/productos.jsp";<%
                                        break;
                    
                                        default:
                                %>window.location.href = "<%= request.getContextPath() %>/index.jsp";<%
                                }
                                %>
                            </script>
                            <%
            
                                return;
                            }
                            %>
                            <%
                            List<Cliente> cliente = ClienteDao.listarClientes();
                            request.setAttribute("list", cliente);
                            %>

                            <header>
                                <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
                                    <div class="container-fluid">
                                        <a class="navbar-brand" href="#">POLLOS LOCOS</a>
                                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
                                            <span class="navbar-toggler-icon"></span>
                                        </button>
                                        <div class="collapse navbar-collapse" id="collapsibleNavbar">
                                            <ul class="navbar-nav">
                                                <li class="nav-item">
                                                    <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/caja/menu.jsp">
                                                        <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                                                        <span>Menú de Productos</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link link-active" href="<%=request.getContextPath()%>/caja/clientes/cartera.jsp?page=1">
                                                        <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-users"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" /><path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /><path d="M21 21v-2a4 4 0 0 0 -3 -3.85" /></svg>
                                                        <span>Gestionar Clientes</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/caja/clientes/anulados.jsp?page=1">
                                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" width="20"  height="20"><path fill="#ffffff" d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM471 143c9.4-9.4 24.6-9.4 33.9 0l47 47 47-47c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9l-47 47 47 47c9.4 9.4 9.4 24.6 0 33.9s-24.6 9.4-33.9 0l-47-47-47 47c-9.4 9.4-24.6 9.4-33.9 0s-9.4-24.6 0-33.9l47-47-47-47c-9.4-9.4-9.4-24.6 0-33.9z"/></svg>
                                                        <span>Clientes Anulados</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito">
                                                        <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-shopping-cart"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M6 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 17h-11v-14h-2" /><path d="M6 5l14 1l-1 7h-13" /></svg>
                                                        <span>Ir a Carrito</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="collapse navbar-collapse" id="collapsibleNavbar">
                                            <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center justify-content-end w-100">
                                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                                                <span class="mx-1">Cerrar Sesión</span>
                                            </a>
                                        </div>
                                    </div>
                                </nav>    
                            </header>

                            <main class="row d-flex align-items-center justify-content-center m-0 py-5">
                                <div class="col-md-3 col-xxl-4"></div>
                                <div class="col-md-6 col-xxl-4">
                                    <h1 class="fw-bold text-center">ACTUALIZACIÓN DE CLIENTE</h1>

                                    <c:if test="${not empty mensajeError}">
                                        <div id="mensajeError">
                                            <c:out value="${mensajeError}" escapeXml="false" />
                                        </div>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/controlCliente?action=actualizar" method="post" onsubmit="return validarCaracteres(event)">

                                        <input type="hidden" name="idCliente" value="${param.idCliente != null ? param.idCliente : cliente.idCliente}">

                                            <div class="mb-3">
                                                <label for="documento" class="form-label fw-bold">DNI/RUC:</label>
                                                <input type="text" id="documento" name="documento" class="form-control" minlength="8" maxlength="11" onkeypress="return soloNumeros(event)" onpaste="return false" value="${param.documento != null ? param.documento : cliente.documento}" required>
                                                    <span id="errorLimiteDni" class="text-danger"></span>
                                                    <span id="errorSoloNumeros" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label for="nombre" class="form-label fw-bold">Nombre:</label>
                                                <input type="text" id="nombre" name="nombre" class="form-control" minlength="4" maxlength="50" onkeypress="return soloLetras(event, 'errorSoloLetrasNombre')" value="${param.nombre != null ? param.nombre : cliente.nombre}" required>
                                                    <span id="errorSoloLetrasNombre" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label for="apellido" class="form-label fw-bold">Apellido:</label>
                                                <input type="text" id="apellido" name="apellido" class="form-control" minlength="4" maxlength="50" onkeypress="return soloLetras(event, 'errorSoloLetrasApellido')" value="${param.apellido != null ? param.apellido : cliente.apellido}" required>
                                                    <span id="errorSoloLetrasApellido" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label for="email" class="form-label fw-bold">Correo Electrónico:</label>
                                                <input type="email" id="email" name="email" class="form-control" minlength="10" maxlength="80" value="${param.email != null ? param.email : cliente.email}" required>
                                            </div>

                                            <div class="text-center">
                                                <button type="submit" class="btn btn-success">Guardar cambios</button>
                                                <a href="${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=1" class="btn btn-secondary">Regresar</a>
                                            </div>

                                    </form>
                                </div>
                                <div class="col-md-3 col-xxl-4"></div>
                            </main>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

                            <script>
                                    function validarCaracteres() {
                                        let doc = document.getElementById("documento");
                                        let docValue = doc.value.trim();
                                        let mensajeVal = document.getElementById("errorLimiteDni");

                                        mensajeVal.textContent = "";
                                        doc.style.border = "1px solid #dee2e6";

                                        if (docValue.length !== 8 && docValue.length !== 11) {
                                            mensajeVal.textContent = "Solo se permite el ingreso de 8 o 11 caracteres.";
                                            doc.style.border = "1px solid red";
                                            event.preventDefault();
                                            return false;
                                        }

                                        return true;
                                    }

                                    function soloNumeros(evt) {
                                        let charCode = (evt.which) ? evt.which : event.keyCode;
                                        let mensajeVal = document.getElementById("errorSoloNumeros");
                                        let inputDoc = document.getElementById("documento");

                                        mensajeVal.textContent = "";
                                        inputDoc.style.border = "1px solid #dee2e6";

                                        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                            mensajeVal.textContent = "Solo se permiten números.";
                                            inputDoc.style.border = "1px solid red";
                                            return false;
                                        }
                                        return true;
                                    }

                                    function soloLetras(evt, error) {
                                        let regex = /^[a-zA-Z\s]*$/;
                                        let key = String.fromCharCode(!evt.charCode ? evt.which : evt.charCode);
                                        let mensajeVal = document.getElementById(error);
                                        let inputActual = evt.target;

                                        mensajeVal.textContent = "";
                                        inputActual.style.border = "1px solid #dee2e6";

                                        if (!regex.test(key)) {
                                            evt.preventDefault();
                                            mensajeVal.textContent = "Solo se permiten letras.";
                                            inputActual.style.border = "1px solid red";

                                            return false;
                                        }
                                    }
                            </script>
                        </body>
                        </html>