<%-- 
    Document   : menu2
    Created on : 9 may. 2024, 19:56:43
    Author     : daniel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@page import="controller.controlCarrito" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/menu.css">
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
        <title>Menú | Pollos Locos</title>
    </head>
    <body class="container-fluid p-0">
        <%
            HttpSession sesion = request.getSession(false);
            String contextPath = request.getContextPath();
            
            if (sesion == null || sesion.getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            String emailRol = (String) ((Usuario) sesion.getAttribute("usuario")).getEmail();
            String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
            if(!"Cajero".equals(nombreRol)){    
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Administrador":
            %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp";<%
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
        <script>
            let contextPath = '<%= contextPath %>';
            let nombreRol = '<%= nombreRol %>';
        </script>
        <%
            List<Producto> listaPollo = ProductoDao.listarPollos();
            request.setAttribute("listaPollo", listaPollo);
    
            List<Producto> listaSopa = ProductoDao.listarSopas();
            request.setAttribute("listaSopa", listaSopa);
            
            List<Producto> listaBebida = ProductoDao.listarBebidas();
            request.setAttribute("listaBebida", listaBebida);
            
            List<Producto> listaPostre = ProductoDao.listarPostres();
            request.setAttribute("listaPostre", listaPostre);
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
                                <a class="nav-link link-active" href="<%=request.getContextPath()%>/caja/menu.jsp">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                                    <span>Menú de Productos</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/caja/clientes/cartera.jsp">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-users"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" /><path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /><path d="M21 21v-2a4 4 0 0 0 -3 -3.85" /></svg>
                                    <span>Gestionar Clientes</span>
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

        <div class="row p-2"> <!-- cambio -->
            <div class="col-md-2 pe-0">
                <div class="">
                    <!-- CATEGORIA POLLOS -->
                    <div class="categoria p-3" style="background-color: #CDDEE5">
                        <img src="<%=request.getContextPath()%>/img/pollos.png" alt="Pollos" onclick="mostrarCategoria('polloContainer')">
                        <h2>Pollos</h2>
                    </div> 



                    <!-- CATEGORIA SOPAS -->
                    <div class="categoria p-3" style="background-color: #F8EDEB">
                        <img src="<%=request.getContextPath()%>/img/sopas.png" alt="Sopas" onclick="mostrarCategoria('sopaContainer')">
                        <h2>Sopas</h2>
                    </div>

                    <!-- CATEGORIA BEBIDAS -->
                    <div class="categoria p-3" style="background-color: #CCBED2">
                        <img src="<%=request.getContextPath()%>/img/bebidas.png" alt="Bebidas" onclick="mostrarCategoria('bebidaContainer')">
                        <h2>Bebidas</h2>
                    </div>

                    <!-- CATEGORIA POSTRES -->
                    <div class="categoria p-3" style="background-color: #ECF1E6">
                        <img src="<%=request.getContextPath()%>/img/postres.png" alt="Postres" onclick="mostrarCategoria('postreContainer')">
                        <h2>Postres</h2>
                    </div>
                </div>
            </div>
            <script>
                function handleErrorImage() {
                    this.onerror = null;
                    this.src ='https://www.mediafire.com/convkey/3ebd/xkltwfdxw34xnrhzg.jpg';
                }
            </script>
            <div class="col-md-10 ps-1">
                <div class='contenedor-productos'>   
                    <!-- PRODUCTOS POLLOS -->
                    <div class="category-container" id="polloContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaPollo}">
                                <div class="product-card cont-product">
                                    <a href="#" onclick="agregarAlCarrito(${prod.getIdProducto()}); return false;">
                                        <img href="" class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" onerror="handleErrorImage.call(this);">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        
                                        <p class="card-text fw-bold">Precio: S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${prod.getPrecio()}" /></p>
                                    </div>
                                    <div class="top-right fw-bold fs-5 p-1">Stock: ${prod.getStock()}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- PRODUCTOS SOPAS -->
                    <div class="category-container" id="sopaContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaSopa}">
                                <div class="product-card card cont-product">
                                    <a href="" onclick="agregarAlCarrito(${prod.getIdProducto()}); return false;">
                                        <img href="" class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" onerror="handleErrorImage.call(this);">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}, ${prod.getIdProducto()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${prod.getPrecio()}" /></p>
                                    </div>
                                    <div class="top-right fw-bold fs-5 p-1">Stock: ${prod.getStock()}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- PRODUCTOS BEBIDAS -->
                    <div class="category-container" id="bebidaContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaBebida}">
                                <div class="product-card card cont-product">
                                    <a href="" onclick="agregarAlCarrito(${prod.getIdProducto()}); return false;">
                                        <img href="" class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" onerror="handleErrorImage.call(this);">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${prod.getPrecio()}" /></p>
                                    </div>
                                    <div class="top-right fw-bold fs-5 p-1">Stock: ${prod.getStock()}</div>
                                </div>
                            </c:forEach>        
                        </div>
                    </div>    

                    <!-- PRODUCTOS POSTRES -->
                    <div class="category-container" id="postreContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaPostre}">
                                <div class="product-card card cont-product">
                                    <a href="" onclick="agregarAlCarrito(${prod.getIdProducto()}); return false;">
                                        <img href="" class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" onerror="handleErrorImage.call(this);">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${prod.getPrecio()}" /></p>
                                    </div>
                                    <div class="top-right fw-bold fs-5 p-1">Stock: ${prod.getStock()}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>   
                </div>
            </div>

        </div>    

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
        <script>
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
                                            window.location.href = contextPath + "/caja/menu.jsp?alert=false";
                                        }
                                    });
                                }
                            }
                            alertBienvenida();

                            function mostrarCategoria(categoriaId) {
                                var contenedores = document.querySelectorAll('.category-container');
                                for (var i = 0; i < contenedores.length; i++) {
                                    if (contenedores[i].id === categoriaId) {
                                        contenedores[i].style.display = 'block';
                                    } else {
                                        contenedores[i].style.display = 'none';
                                    }
                                }
                            }

                            document.addEventListener("DOMContentLoaded", function () {
                                var contenedores = document.querySelectorAll('.category-container');
                                for (var i = 0; i < contenedores.length; i++) {
                                    if (contenedores[i].id !== 'polloContainer') {
                                        contenedores[i].style.display = 'none';
                                    }
                                }
                            });
        </script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
    </body>
</html>
