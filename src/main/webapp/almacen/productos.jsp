<%@ page import="model.Producto" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="java.util.List" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%
    List<Producto> producto = ProductoDao.listarProductos();
    request.setAttribute("list", producto);
%>
<body>
<%-- TABLA GENERAL --%>
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
</body>
</html>
