<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<%@ page import="model.Producto" %>
<%@ page import="dao.ProductoDao" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Title</title>
</head>
<body>
<%
    String spageid=request.getParameter("page");
    int pageid=Integer.parseInt(spageid);
    int total=5;
    if(pageid==1){}
    else{
        pageid=pageid-1;
        pageid=pageid*total+1;
    }
    List<Producto> producto = ProductoDao.listarProductosPagina(pageid,total);
    request.setAttribute("list", producto);

%>
<tbody>
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
        <!-- th></th>
        <th></th -->
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="prod">
        <tr>
            <td>${prod.getIdProducto()}</td>
            <td>${prod.getNombreCategoria()}</td>
            <td>${prod.getNombre()}</td>
            <td>${prod.getDescripcion()}</td>
            <td><img src="${pageContext.request.contextPath}/cloud-images/${prod.getFoto()}" alt=""
                     width="50"></td>
            <td>${prod.getPrecio()}</td>
            <td>${prod.getStock()}</td>
            <td>
                <c:choose>
                    <c:when test="${prod.getEstado() == 0}">Inactivo</c:when>
                    <c:when test="${prod.getEstado() == 1}">Activo</c:when>
                    <c:otherwise>Estado Desconocido</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<nav aria-label="Page navigation example">
    <ul class="pagination">
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/almacen/products.jsp?page=1">1</a></li>
        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/almacen/products.jsp?page=2">2</a></li>
        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/almacen/products.jsp?page=3">3</a></li>
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>
</tbody>
</body>
</html>
