<%@ page import="model.DetalleVenta" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DetalleVentaDao" %>
<%@ page import="model.Venta" %>
<%@ page import="dao.VentaDao" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
    <title>Title</title>
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
    <HR>
</div>

<p>Hora y fecha de venta: <%= vent.getHoraVenta()%></p>
<p>Nombre cliente: <%= vent.getNombre()%>, <%= vent.getApellido()%></p>

<p>Método de pago:
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
        </tr>
        </c:forEach>
    </tbody>
</table>
<button id="procesar-venta" onclick="print()" type="submit">Descargar comprobante</button>
</body>
</html>
