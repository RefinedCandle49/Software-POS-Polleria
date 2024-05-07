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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
</head>
<body>
<div class="container my-4">
    <ul class="list-unstyled">
        <li>
            <a href="<%=request.getContextPath()%>/caja/menu.jsp"><i class="fa-light fa-arrow-left px-2"></i>Seguir
                comprando</a>
        </li>
    </ul>
    
    <div class="row pt-5 pb-5">
        <c:if test="${totalPagar > 0}">
            <div class="col-lg-8 table-responsive">
                <div class="printed">
                    <h1>POLLOS LOCOS</h1>
                    <h2>Pollería Pollos Locos S.A.C</h2>
                    <h3>Av. JAVIER PRADO ESTE NRO. 6210 INT. 1201 URB. RIVERA DE MONTERRICO LA MOLINA LIMA - LIMA</h3>
                    <H3>BOLETA DE VENTA ELECTRÓNICA</H3>
                    <HR>
                    <div class="grid">
                        <div class="grid-item"><p id="current-date"></p></div>
                        <div class="grid-item"><p id="current-time"></p></div>
                        <div class="grid-item"><p>NoCaja: 4251</p></div>
                    </div>
                
                </div>
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th>SKU</th>
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
                            <td class="align-middle">${car.getIdProducto()}</td>
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
            <form action="<%=request.getContextPath()%>/controlCarrito?accion=RealizarVenta" method="post">
                
                
                <label> DNI/RUC: <input type="text" id="idCliente" name="idCliente"
                                        placeholder="Ingrese ID del Cliente">
                    <button type="button" id="buscar">Buscar Cliente</button>
                    <button type="button" id="limpiar">Limpiar</button>
                    <label id="nombreDisplay"></label> </label>
                <script> document.getElementById("limpiar").addEventListener("click", function () {
                    document.getElementById("idCliente").value = "";
                    document.getElementById("nombreDisplay").innerText = "";
                }); </script>
                
                
                <div>
                    <label>
                        <input type="radio" name="metodoPago" id="efectivo" value="1"
                               required/>
                        Efectivo
                    </label>
                    <label>
                        <input type="radio" name="metodoPago" id="tarjeta"
                               value="2"/>
                        Tarjeta
                    </label>
                </div>
                
                <button id="procesar-venta" onclick="print()" type="submit">Procesar venta</button>
            </form>
        
        
        </c:if>
        <c:if test="${totalPagar > 0}">
            <%@ page import="java.text.DecimalFormat" %>
            <%
                if (request.getAttribute("totalPagar") != null) {
                    double totalPagar = Double.parseDouble(request.getAttribute("totalPagar").toString());
                    
                    DecimalFormat df = new DecimalFormat("#.##");
                    
                    String totalFormateado = df.format(totalPagar);
            
            %>
            
            <div class="col-sm-4">
                <p>Subtotal: S/ <%=totalFormateado%>
                </p>
                <hr class="my-2">
                <p style="font-weight:700">Total a pagar: S/ <%=totalFormateado%>
                </p>
                    <%--                <a href="#" id="btnRealizarPago" class="btn btn-warning text-center">Procesar venta</a>--%>
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
            <p>El carrito está vacío.</p>
        </c:if>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function getCurrentDateTime() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();

        // Agrega un cero delante si los segundos son menores que 10
        seconds = (seconds < 10) ? "0" + seconds : seconds;

        minutes = (minutes < 10) ? "0" + minutes : minutes;

        var timeString = hours + ':' + minutes + ':' + seconds;

        document.getElementById("current-time").innerHTML = "Hora actual: " + timeString;

        var day = now.getDate();
        var month = now.getMonth() + 1;
        var year = now.getFullYear();

        var dateString = day + '/' + month + '/' + year;

        document.getElementById("current-date").innerHTML = "Fecha actual: " + dateString;
    }

    // Llama a la función getCurrentDateTime cada segundo para actualizar la hora y fecha
    setInterval(getCurrentDateTime, 1000);
</script>
<script>
    const cantidadInput = document.getElementById('Cantidad');

    cantidadInput.addEventListener('input', function () {
        // Eliminar el carácter "-" si se ingresa
        if (cantidadInput.value.includes('-')) {
            cantidadInput.value = cantidadInput.value.replace('-', '');
        }
    });
</script>
</body>
</html>
