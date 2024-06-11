<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<%@ page import="model.Producto" %>
<%@ page import="dao.ProductoDao" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
    <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
    <title>Productos | Pollos Locos</title>
</head>
<%
            HttpSession sesion = request.getSession(false);
            String contextPath = request.getContextPath();
            
            if (sesion == null || sesion.getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            String emailRol = (String) ((Usuario) sesion.getAttribute("usuario")).getEmail();
            String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
            if(!"Almacenero".equals(nombreRol)){    
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Cajero":
            %>window.location.href = "<%= request.getContextPath() %>/caja/menu.jsp";<%
                    break;
                    
                case "Administrador":
            %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp";<%
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
    String spageid=request.getParameter("page");
    int pageid=Integer.parseInt(spageid);
    int total=10;
    if(pageid==1){}
    else{
        pageid=pageid-1;
        pageid=pageid*total+1;
    }
    List<Producto> producto = ProductoDao.listarProductosPagina(pageid,total);
    request.setAttribute("list", producto);
    
    int totalProductos = ProductoDao.contarProductos();
    int totalPages = (int) Math.ceil((double) totalProductos / total); // Calcula el número total de páginas
%>
<body>
    <div class="container-fluid overflow-hidden">
        <div class="row vh-100 overflow-auto">
            <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-3 col-xxl-2 px-sm-2 px-0 bg-dark sticky-top">
                <nav class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
                    <div class="w-100 text-center text-light">
                        <span class="d-none d-sm-inline fs-6" style="opacity: 0.5">Sistema de Gestión</span>
                        <br><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                    </div>

                    <div class="w-100 text-center text-light">
                        <img src="${pageContext.request.contextPath}/img/user-icon.png" class="img-fluid img-css py-3" alt="..."/>
                        <br><span class="d-none d-sm-inline w-100"><%= nombreRol %></span>
                        <br><span class="d-none d-sm-inline w-100" style="opacity: 0.5; word-break: break-all !important;"><%= emailRol %></span>
                    </div>
                    <hr>

                    <ul class="nav flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
                        <li class="nav-item pb-4">
                            <a href="${pageContext.request.contextPath}/almacen/productos.jsp?page=1" class="link-active align-middle px-0">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-meat"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13.62 8.382l1.966 -1.967a2 2 0 1 1 3.414 -1.415a2 2 0 1 1 -1.413 3.414l-1.82 1.821" /><path d="M5.904 18.596c2.733 2.734 5.9 4 7.07 2.829c1.172 -1.172 -.094 -4.338 -2.828 -7.071c-2.733 -2.734 -5.9 -4 -7.07 -2.829c-1.172 1.172 .094 4.338 2.828 7.071z" /><path d="M7.5 16l1 1" /><path d="M12.975 21.425c3.905 -3.906 4.855 -9.288 2.121 -12.021c-2.733 -2.734 -8.115 -1.784 -12.02 2.121" /></svg>
                                <span class="ms-1 d-none d-sm-inline">Tabla de Productos</span>
                            </a>
                        </li>
                                
                        <li>
                            <a href="${pageContext.request.contextPath}/almacen/productos/registrar.jsp" class="link-inactive align-middle px-0">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                                <span class="ms-1 d-none d-sm-inline">Registrar Producto</span>
                            </a>
                        </li>
                    </ul>
                    <hr>
                    <div class="pb-3">
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center w-100">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                            <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                        </a>
                    </div>
                </nav>
            </header>
        
            <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-9 col-xxl-10 flex-column h-sm-100">
                <section>
                    <c:if test="${not empty list}">
                    <h1 class="fw-bold">PANEL DE PRODUCTOS</h1>

                    <div class="d-flex align-items-center justify-content-end">
                        <a href="${pageContext.request.contextPath}/almacen/productos/registrar.jsp" class="btn btn-primary">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                            <span class="ms-1">Ir a registrar producto</span>
                        </a>
                    </div>
                    
                    <c:if test="${empty list}">
                        <span>¡Hola! Parece que esta tabla está vacía en este momento. ¡Ingresa datos para llenarla!</span>
                    </c:if>
                            
                    <c:if test="${not empty param.registroExitoso}">
                        <div id="registroExitoso" class="alert alert-success d-flex align-items-center justify-content-between my-2">
                            ${param.registroExitoso}
                            <button type="button" class="button-mensaje text-success" onclick="cerrarMensaje()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                        </div>
                    </c:if>
                
                    <div class="table-responsive-md my-2">
                        <table class="table table-striped">
                            <thead class="table-dark">
                            <tr>
                                <th style="display: none">ID</th>
                                <th>CÓDIGO</th>
                                <th>CATEGORÍA</th>
                                <th>NOMBRE</th>
                                <th>DESCRIPCIÓN</th>
                                <th>FOTO</th>
                                <th>PRECIO</th>
                                <th>STOCK</th>
                                <th>ESTADO</th>
                                <!-- th></th>
                                <th></th -->
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${list}" var="prod">
                                <tr>
                                    <td style="display: none">${prod.getIdProducto()}</td>
                                    <td>${prod.getCodigo()}</td>
                                    <td>${prod.getNombreCategoria()}</td>
                                    <td>${prod.getNombre()}</td>
                                    <td>${prod.getDescripcion()}</td>
                                    <script>
                                        function handleErrorImage() {
                                            this.onerror = null;
                                            this.src ='https://www.mediafire.com/convkey/78b7/26g1s3awdx09l0o9g.jpg';
                                        }
                                    </script>
                                    
                                    <td>
                                        <img src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" width="50" onerror="handleErrorImage.call(this);">
                                    </td>
                                    
                                    
                                    <td style="text-wrap: nowrap;">${prod.getPrecio()}</td>
                                    <td>${prod.getStock()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prod.getEstado() == 0}">No Disponible</c:when>
                                            <c:when test="${prod.getEstado() == 1}">Disponible</c:when>
                                            <c:otherwise>Estado Desconocido</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="d-flex justify-content-center">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/almacen/productos.jsp?page=1" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <%
                                    for(int i = 1; i <= totalPages; i++) {
                                %>
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/almacen/productos.jsp?page=<%=i%>"><%=i%></a></li>
                                <% } %>
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/almacen/productos.jsp?page=<%=totalPages%>" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </c:if>
                </section>
            </main>
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
                    icon: "success",
                    title: 'Bienvenido, ' + nombreRol,
                    confirmButtonColor: "#0A5ED7",
                    confirmButtonText: "Aceptar",
                    allowOutsideClick: false
            }).then((result) => {
                    if (result.isConfirmed) {
                    window.location.href = contextPath + "/almacen/productos.jsp?alert=false&page=1";
                    }
                });
            }
        }
        alertBienvenida()
        
        function cerrarMensaje() {
            let registroExitoso = document.getElementById("registroExitoso");
            registroExitoso.style.display = "none";
            window.location.href = "${pageContext.request.contextPath}/almacen/productos.jsp?page=1"
        }
    </script>
    
</body>
</html>
