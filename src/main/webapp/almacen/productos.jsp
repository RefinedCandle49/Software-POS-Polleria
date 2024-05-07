<%@ page import="model.Producto" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="java.util.List" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css">
</head>
<%
    List<Producto> producto = ProductoDao.listarProductos();
    request.setAttribute("list", producto);
%>
<body>
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
                <nav class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
                    <div class="w-100 text-center text-light">
                        <span class="d-none d-sm-inline fs-6" style="opacity: 0.5">Sistema de Gestión</span>
                        <br><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                    </div>

                    <div class="w-100 text-center text-light">
                        <img src="${pageContext.request.contextPath}/img/user-icon.png" class="img-fluid img-css py-3" alt="..."/>
                        <br><span class="d-none d-sm-inline w-100">nombreRol</span>
                        <span class="d-none d-sm-inline w-100" style="opacity: 0.5">emailRol</span>
                    </div>
                    <hr>

                    <ul class="nav flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">

                        <li class="nav-item pb-4">
                            <a href="${pageContext.request.contextPath}/admin/usuarios.jsp" class="link-active align-middle px-0">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-users"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" /><path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /><path d="M21 21v-2a4 4 0 0 0 -3 -3.85" /></svg>
                                <span class="ms-1 d-none d-sm-inline">Usuarios</span>
                            </a>
                        </li>

                        <li class="nav-item pb-4">
                            <a href="${pageContext.request.contextPath}/admin/ventas.jsp" class="link-inactive align-middle px-0">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M5 21v-16a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v16l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2" /><path d="M14 8h-2.5a1.5 1.5 0 0 0 0 3h1a1.5 1.5 0 0 1 0 3h-2.5m2 0v1.5m0 -9v1.5" /></svg>
                                <span class="ms-1 d-none d-sm-inline">Ventas</span></a>
                        </li>

                        <li class="nav-item pb-4">
                            <a href="${pageContext.request.contextPath}/admin/reportes/ventas.jsp" class="link-inactive align-middle px-0">
                                <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-chart-bar"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M3 12m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v6a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M9 8m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v10a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M15 4m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M4 20l14 0" /></svg>
                                <span class="ms-1 d-none d-sm-inline">Reportes</span></a>
                        </li>
                    </ul>
                    <hr>
                    <div class="pb-4">
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center w-100">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                            <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                        </a>
                    </div>
                </nav>
            </header>
            <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-10">
                <c:if test="${not empty list}">
    <h3 class="mt-4 mb-2">TABLA GENERAL</h3>
    
    <div class="d-flex justify-content-between w-100 my-2">
        <div>
            <a class="btn btn-primary mt-2" href="${pageContext.request.contextPath}/admin/register/producto.jsp">Agregar
                Producto</a>
        </div>
        <div>
            <a class="btn btn-warning text-light mt-2" href="${pageContext.request.contextPath}/admin/categorias.jsp">Gestionar
                Categorias</a>
        </div>
    </div>
    
    <div class="table-responsive-md">
        <table class="table table-bordered container" border="1">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>CATEGORÍA</th>
                <th>NOMBRE</th>
                <th>DESCRIPCIÓN</th>
                <th>FOTO</th>
                <th>PRECIO</th>
                <th>STOCK</th>
                <th>ESTADO</th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="prod">
                <tr>
                    <td>${prod.getIdProducto()}</td>
                    <td>${prod.getNombreCategoria()}</td>
                    <td>${prod.getNombre()}</td>
                    <td>${prod.getDescripcion()}</td>
                    <td><img src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" alt=""></td>
                    <td>${prod.getPrecio()}</td>
                    <td>${prod.getStock()}</td>
                    <td>
                        <c:choose>
                            <c:when test="${prod.getEstado() == 0}">Inactivo</c:when>
                            <c:when test="${prod.getEstado() == 1}">Activo</c:when>
                            <c:otherwise>Estado Desconocido</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a class="btn btn-success btn-sm"
                           href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${prod.getIdProducto()}">Modificar</a>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                            <input type="hidden" id="idProducto" name="idProducto"
                                   value="${prod.getIdProducto()}">
                            <input type="hidden" name="action" value="eliminar">
                            <button class="btn btn-danger btn-sm" type="submit">Eliminar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
