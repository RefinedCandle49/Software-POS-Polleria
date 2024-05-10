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
<!DOCTYPE html>
<html>
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
        <title>Menú | Pollos Locos</title>
        <style>
            /* CATEGORIAS */
            
            body {
                position: relative;
                overflow-x: hidden;
                overflow-y: hidden;
            }
            
            .categoria {
                text-align: center;
                box-sizing: border-box;
                border-radius: 5px;
                margin-top: 4px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                cursor: pointer;
            }

            .category-container {
                display: flex;
                align-items: center;
                width: 100%;
            }

            .categoria img {
                width: 69px;
                height: 72px;
            }

            /* PRODUCTOS */

            .product-container {
                display: flex;
                flex-wrap: wrap;
                overflow-y: auto;
                max-height: calc(100vh - 150px);
            }

            .product-card {
                width: 215px;
                height: 260px;
                margin: 4px;
                display: inline-block;
                vertical-align: top;
                border: 1px solid black;
                border-radius: 2px;
                box-sizing: border-box;
            }

            .product-card .horizontal {
                display: inline-block;
            }

            .product-card a {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .product-card img {
                padding: 3px;
                width: 200px;
                height: 200px;
            }

            .card-body {
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 0;
            }

            .card-body h5 {
                color: gray;
                max-width: 100%;
                margin: 0;
                text-align: center;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                padding: 0;
            }
        </style>
    </head>
    <body class="container-fluid">
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

        <header class="p-3">
            <nav>
                <div class="d-flex align-items-center justify-content-between">
                    <span class="fs-5 fw-bold">Bienvenido, <%= nombreRol %></span>

                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito" class="text-dark">
                        <svg  xmlns="http://www.w3.org/2000/svg"  width="50"  height="50"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-shopping-cart"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M6 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 17h-11v-14h-2" /><path d="M6 5l14 1l-1 7h-13" /></svg>
                    </a>
                </div>
            </nav>
        </header>

        <div class="row">
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

            <div class="col-md-10 ps-1">
                <div class='contenedor-productos'>   
                    <!-- PRODUCTOS POLLOS -->
                    <div class="category-container" id="polloContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaPollo}">
                                <div class="product-card">
                                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}">
                                        <img href="" class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ ${prod.getPrecio()}</p>  
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- PRODUCTOS SOPAS -->
                    <div class="category-container" id="sopaContainer">    
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaSopa}">
                                <div class="product-card card">
                                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ ${prod.getPrecio()}</p>  
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- PRODUCTOS BEBIDAS -->
                    <div class="category-container" id="bebidaContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaBebida}">
                                <div class="product-card card">
                                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ ${prod.getPrecio()}</p>  
                                    </div>
                                </div>
                            </c:forEach>        
                        </div>
                    </div>    

                    <!-- PRODUCTOS POSTRES -->
                    <div class="category-container" id="postreContainer">
                        <div class="product-container">
                            <c:forEach var="prod" items="${listaPostre}">
                                <div class="product-card card">
                                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="fw-bold">${prod.getNombre()}</h5>
                                        <p class="card-text fw-bold">Precio: S/ ${prod.getPrecio()}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>   
                </div>
            </div>

        </div>    
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function alertBienvenida() {
            const url = new URLSearchParams(window.location.search);
            const alert = url.get('alert');

            if (alert === 'true') {
                Swal.fire({
                    icon: "info",
                    title: 'Bienvenido, ' + nombreRol,
                    confirmButtonColor: "#212529",
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
    </body>
</html>
