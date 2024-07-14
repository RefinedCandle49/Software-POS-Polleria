<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@ page import="model.DetalleVenta" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DetalleVentaDao" %>
<%@ page import="model.Venta" %>
<%@ page import="dao.VentaDao" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
    <title>Comprobante | Pollos Locos</title>
</head>
<body>
<%
    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
    
    List<DetalleVenta> detalles = DetalleVentaDao.listarDetalleVenta(idVenta);
    request.setAttribute("list", detalles);
    
    Venta vent = VentaDao.obtenerVentaPorId(idVenta);
    
    String horaFecha = vent.getFechaHoraVenta(); // Obtener la fecha y hora de venta desde tu backend

// Crear un objeto SimpleDateFormat para parsear la fecha y hora de venta
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date fechaHoraVenta = sdf.parse(horaFecha);

// Formatear la fecha y hora de venta en los formatos deseados
    SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
    String fechaFormateada = sdfFecha.format(fechaHoraVenta);
    
    SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm:ss");
    String horaFormateada = sdfHora.format(fechaHoraVenta);
    
    double totalPagar = vent.getTotal();
    double IGV = totalPagar * 0.18;
    double totalMenosIgv = totalPagar - IGV;
%>


<div class="container my-4">
    <div class="row pb-5">
        <div>
            <div class="text-center">
                <h1>POLLOS LOCOS</h1>
                <h2>Pollería Pollos Locos S.A.C</h2>
                <h3>Av. JAVIER PRADO ESTE NRO. 6210 INT. 1201 URB. RIVERA DE MONTERRICO LA MOLINA LIMA - LIMA</h3>
                <H3>BOLETA DE VENTA ELECTRÓNICA</H3>
                <h3><%= vent.getCodigo() %></h3>
                <HR>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col">
                        <p id="current-date">
                            Fecha actual:
                            <%= fechaFormateada %>
                        </p>
                        <p>DNI/RUC: <%= vent.getDocumento()%>
                        </p>
                        <p class="me-3">Cliente: <%= vent.getNombre()%>, <%= vent.getApellido()%>
                        </p>
                    </div>
                    <div class="col">
                        <p id="current-time">
                            Hora actual:
                            <%= horaFormateada %>
                        </p>
                    </div>
                </div>
                
                <div>
                    <HR>
                    <table class="table table-bordered text-center border border-white ">
                        <thead>
                        <tr>
                            <th>SKU</th>
                            <th>Producto</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>SubTotal</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="det">
                            <tr>
                                <td class="align-middle">${det.getIdVenta()}</td>
                                <td class="align-middle">${det.getNombre()}</td>
                                <td class="align-middle">S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${det.getSubTotal() / det.getCantidad()}"/> </td>
                                <td class="align-middle">${det.getCantidad()}</td>
                                <td>S/${det.getSubTotal()}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="text-end">
                    <p>Monto Base: S/<%= String.format("%.2f", totalMenosIgv) %></p>
                    <p>IGV (18%): S/<%= String.format("%.2f", IGV) %></p>
                    <HR class="my-2">
                    <p style="font-weight:700">Total a Pagar: S/<%= String.format("%.2f", totalPagar) %></p>
                </div>
                
                <div class="text-center">
                    <button id="procesar-venta" onclick="print()" type="submit" class="btn btn-primary">Descargar
                        comprobante
                    </button>
                    
                    <a class="text-white text-decoration-none" href="<%=request.getContextPath()%>/admin/ventas.jsp?page=1">
                       <button id="regresar" class="btn btn-secondary">Regresar</button>
                    </a>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>
