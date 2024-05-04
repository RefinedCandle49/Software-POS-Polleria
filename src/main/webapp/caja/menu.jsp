<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@page import="controller.controlCarrito" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <title>Menú de productos</title>
</head>
<body>
<%
    List<Producto> listaPollo = ProductoDao.listarPollos();
    request.setAttribute("listaPollo", listaPollo);
    
    List<Producto> listaSopa = ProductoDao.listarSopas();
    request.setAttribute("listaSopa", listaSopa);
    
%>

<a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito" class="text-dark w-100">Carrito<i class="fa-light fa-cart-shopping px-1"></i></a>
<a href="<%=request.getContextPath()%>/almacen/productos/registrar.jsp">Agregar producto</a>
<h1>Pollos</h1>
<c:forEach var="prod" items="${listaPollo}">
    <div class="col-lg-4 col-md-6 col-sm-12 mx-auto my-4">
        <div class="card w-100" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}"
                   class="btn btn-primary">
                    <img class="card-img-top"
                         src="${prod.getFoto()}">
                </a>
                <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
            </div>
        </div>
    </div>
</c:forEach>
<h1>Sopas</h1>
<c:forEach var="prod" items="${listaSopa}">
    <div class="col-lg-4 col-md-6 col-sm-12 mx-auto my-4">
        <div class="card w-100" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}"
                   class="btn btn-primary">
                    <img class="card-img-top"
                         src="${prod.getFoto()}">
                </a>
                <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
            </div>
        </div>
    </div>
</c:forEach>
<h1>Gaseosas</h1>
<h1>Postres</h1>



<%--<form action="${pageContext.request.contextPath}/UploadServlet" method="post" enctype="multipart/form-data">--%>
<%--    <input type="file" name="image">--%>
<%--    <input type="submit" value="Subir Imagen">--%>
<%--</form>--%>
</body>
</html>
