<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú de productos</title>
</head>
<body>
<%
    List<Producto> miLista = ProductoDao.listarPollos();
    request.setAttribute("Productos", miLista);
%>
<%
    int contador = 1;
%>
<c:forEach var="prod" items="${Productos}">
    <div class="col-lg-4 col-md-6 col-sm-12 mx-auto my-4">
        <div class="card w-100" style="width: 18rem;">
            <img class="card-img-top"
                 src="<%=request.getContextPath()%>/img/Pizzas/<%=contador%>.png"
                 alt="img_pizza_1">
            <div class="card-body">
                <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                <p class="card-text">${prod.getDescripcion()}</p>
                <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}"
                   class="btn btn-primary">Añadir a carrito</a>
            </div>
        </div>
    </div>
    <%
        contador++;
    %>
</c:forEach>
</body>
</html>
