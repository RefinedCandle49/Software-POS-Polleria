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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin:0;
            padding:0;
            background-color: white;
            position: relative;
            overflow-x: hidden;
            overflow-y: hidden;
        }

        .nav-links {
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 20px;
            box-sizing: border-box;
        }

        .nav-links .left {
            left: 20px;
            margin: 10px;
            margin-left: 60px;
            display: flex;
            align-items: center;
        }

        .nav-links .right {
            right: 20px;
            margin: 10px;
            display: flex;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #000;
        }

        .menu-categorias {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 200px;
            background-color: white;
            margin-bottom: 60px;
        }

        .category-container {
            margin: 20px;
            display: flex;
            align-items: center;
            width: 99%;
            margin-top: 0;
        }

        .categoria {
            text-align: center;
            padding: 20px;
            box-sizing: border-box;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-left: 20px;
            margin-bottom: 20px;
            width: 170px; /* Ancho fijo */
            height: 170px; /* Altura fija */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .categoria img {
            width: 100px;
            height: 100px;
        }

        .categoria h2 {
            width: 350px;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .contenedor-productos {
            margin-left: 180px;
        }

        .product-container {
            margin: 20px;
            display: flex;
            flex-wrap: wrap;
            overflow-y: auto;
            max-height: calc(100vh - 210px);
        }

        .product-card {
            width: 260px;
            height: 300px;
            margin: 5px;
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
            background-color: white;
            justify-content: center;
            align-items: center;
        }

        .product-card img {
            padding: 5px;
            width: 250px;
            height: 250px;
            background-color: white;
        }

        .card-body {
            background-color: white;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0;
        }

        .card-body h5 {
            color: gray;
            font-weight: 600;
            max-width: 100%;
            margin: 0;
            text-align: center;
            overflow: hidden;
            padding: 0;
        }

        .card-body p {
            color: black;
            font-weight: 600;
            margin: 0;
        }

        @media only screen and (max-width: 1366px) and (max-height: 768px) {
            .menu-categorias {
                position: fixed;
                width: 200px;
                height: 500px;
                background-color: white;
                margin-bottom: 60px;
            }

            .categoria {
                text-align: center;
                padding: 20px;
                box-sizing: border-box;
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-left: 40px;
                width: 100px; /* Ancho fijo */
                height: 100px; /* Altura fija */
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                cursor: pointer;
            }

            .categoria img {
                width: 50px;
                height: 50px;
            }

            .categoria h2 {
                width: 350px;
                margin-top: 5px;
                margin-bottom: 5px;
            }
        }
    
    
    </style>
</head>
<body>
<%
    List<Producto> listaPollo = ProductoDao.listarPollos();
    request.setAttribute("listaPollo", listaPollo);
    
    List<Producto> listaSopa = ProductoDao.listarSopas();
    request.setAttribute("listaSopa", listaSopa);
    
%>

<div class="nav-links">
    <div class="left">
        <a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito" class="text-dark w-100"><i class="fa-light fa-cart-shopping px-1" style="font-size: 50px;"></i></a>
    </div>
    <div class="right">
        <a href="<%=request.getContextPath()%>/almacen/productos/registrar.jsp" style="font-size: 20px; background-color: black; color: white; padding: 10px 20px; border-radius: 10px;">AGREGAR PRODUCTO</a>
    </div>
</div>

<div class="menu-categorias">
    
    <!-- CATEGORIA POLLOS -->
    <div class="categoria">
        <img src="<%=request.getContextPath()%>/img/pollos.png" alt="Pollos" onclick="mostrarCategoria('polloContainer')">
        <h2>Pollos</h2>
    </div>
    
    <!-- CATEGORIA SOPAS -->
    <div class="categoria">
        <img src="<%=request.getContextPath()%>/img/sopas.png" alt="Sopas" onclick="mostrarCategoria('sopaContainer')">
        <h2>Sopas</h2>
    </div>
    
    <!-- CATEGORIA BEBIDAS -->
    <div class="categoria">
        <img src="<%=request.getContextPath()%>/img/bebidas.png" alt="Bebidas" onclick="mostrarCategoria('bebidaContainer')">
        <h2>Bebidas</h2>
    </div>
    
    <!-- CATEGORIA POSTRES -->
    <div class="categoria">
        <img src="<%=request.getContextPath()%>/img/postres.png" alt="Postres" onclick="mostrarCategoria('postreContainer')">
        <h2>Postres</h2>
    </div>
</div>

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
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
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
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
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
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
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
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>


    function mostrarCategoria(categoriaId) {
        var contenedores = document.querySelectorAll('.category-container');
        for (var i = 0;i < contenedores.length; i++) {
            if (contenedores[i].id === categoriaId) {
                contenedores[i].style.display = 'block';
            }else {
                contenedores[i].style.display = 'none';
            }
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        // Ocultamos todos los demás contenedores a excepcion de el de pollos
        var contenedores = document.querySelectorAll('.category-container');
        for (var i = 0;i < contenedores.length; i++){
            if (contenedores[i].id !== 'polloContainer') {
                contenedores[i].style.display = 'none';
            }
        }
    });


</script>

<%--<form action="${pageContext.request.contextPath}/UploadServlet" method="post" enctype="multipart/form-data">--%>
<%--    <input type="file" name="image">--%>
<%--    <input type="submit" value="Subir Imagen">--%>
<%--</form>--%>
</body>
</html>
