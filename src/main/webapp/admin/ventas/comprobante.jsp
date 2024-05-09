<%@ page import="model.DetalleVenta" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DetalleVentaDao" %>
<%@ page import="model.Venta" %>
<%@ page import="dao.VentaDao" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<html>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
    <title>Comprobante</title>
</head>
<body>
<%
    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
    
    List<DetalleVenta> detalles = DetalleVentaDao.listarDetalleVenta(idVenta);
    request.setAttribute("list", detalles);
    
    Venta vent = VentaDao.obtenerVentaPorId(idVenta);
    
%>
<div class="comprobante">
    <h1>POLLOS LOCOS</h1>
    <h2>Pollería Pollos Locos S.A.C</h2>
    <h3>Av. JAVIER PRADO ESTE NRO. 6210 INT. 1201 URB. RIVERA DE MONTERRICO LA MOLINA LIMA - LIMA</h3>
    <H3>BOLETA DE VENTA ELECTRÓNICA</H3>
    <hr>
</div>

<div class="container">
<div class="row"> 
    <div class="d-flex justify-content-between align-items-center">
<p class="me-3">Hora y fecha de venta: <%= vent.getHoraVenta()%></p>
<p class="me-3">Nombre cliente: <%= vent.getNombre()%>, <%= vent.getApellido()%></p>
<p class="me-3">Método de pago:
    <%
        int metodoPago = vent.getMetodoPago();
        if(metodoPago == 0) {
    %>
    Efectivo
    <%
    } else if(metodoPago == 1) {
    %>
    Tarjeta
    <%
        }
    %></p>
    </div>

    <div>
        <hr>
<table class="table table-bordered text-center">
    <thead>
    <tr>
        <th>SKU</th>
        <th>Producto</th>
        <th>Cantidad</th>
    </tr>
    </thead>
    <tbody>
        <c:forEach items="${list}" var="det">
        <tr>
            <td class="align-middle">${det.getIdVenta()}</td>
            <td class="align-middle">${det.getNombre()}</td>
            <td class="align-middle">${det.getCantidad()}</td>
            <td>${det.getSubTotal()}</td>
        </tr>
        </c:forEach>
    </tbody>
</table>
<button id="procesar-venta" onclick="print()" type="submit" class="float-end">Descargar comprobante</button>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
