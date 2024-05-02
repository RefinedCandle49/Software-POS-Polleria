
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
</head>
<body>
<div class="container my-4">
    <ul class="list-unstyled">
        <li>
            <a href="<%=request.getContextPath()%>/caja/menu.jsp" class="text-dark"><i class="fa-light fa-arrow-left px-2"></i>Seguir comprando</a>
        </li>
    </ul>
    
    <div class="row pt-5 pb-5">
        <c:if test="${totalPagar > 0}">
            <div class="col-lg-8 table-responsive">
                
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>SubTotal</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="car" items="${carrito}">
                        <tr>
                            <td class="align-middle">${car.getNombre()}</td>
                            <td class="align-middle">S/ ${car.getPrecio()}</td>
                            <td class="align-middle">
                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                <input type="number" min="1" step="1" id="Cantidad" value="${car.getCantidad()}"
                                       class="form-control">
                            </td>
                            <td class="align-middle">S/ ${car.getSubtotal()}</td>
                            <td class="align-middle">
                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Delete&idp=${car.getIdProducto()}"
                                   id="btnDetele" class="">
                                    <i class="fa-solid fa-xmark fa-lg" style="color: #000000;"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            
            </div>
        </c:if>
        <c:if test="${totalPagar > 0}">
            <%@ page import="java.text.DecimalFormat" %>
            <%
                if (request.getAttribute("totalPagar") != null) {
                    double totalPagar = Double.parseDouble(request.getAttribute("totalPagar").toString());
                    
            %>
            
            <div class="col-sm-4">
                <p>Subtotal: S/ ${totalPagar}</p>
                <hr class="my-2">
                <p style="font-weight:700">Total a pagar: S/ ${totalPagar}</p>
                <a href="#" id="btnRealizarPago" class="btn btn-warning text-center">Realizar pago</a>
            </div>
            
            <% } else { %>
            <!-- Manejar el caso cuando totalPagar no está disponible -->
            <p>No se pudo calcular el total a pagar.</p>
            <% } %>
        
        </c:if>
    </div>
    
    <div class="icon-carrito">
        <c:if test="${totalPagar <= 0}">
            <i class="fa-duotone fa-cart-xmark fa-10x"></i>
            <p>EL carrito está vacío.</p>
        </c:if>
    </div>
</div>




<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function realizarPago() {
        var totalPagar = ${totalPagar};
        if (totalPagar == 0) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se puede realizar el pago',
            });
            return;
        }
        window.location.href = "<%=request.getContextPath()%>/checkout.jsp";
    }

    document.getElementById("btnRealizarPago").addEventListener("click", realizarPago);
</script>
</body>
</html>
