<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Comprobante | Pollos Locos</title>
</head>
<body>
<%
    String horaFecha = (String) request.getAttribute("FechaHoraActual");
    
    // Crear un objeto SimpleDateFormat para parsear la fecha y hora de venta
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date fechaHoraVenta = sdf.parse(horaFecha);

// Formatear la fecha y hora de venta en los formatos deseados
    SimpleDateFormat sdfFecha = new SimpleDateFormat("dd/MM/yyyy");
    String fechaFormateada = sdfFecha.format(fechaHoraVenta);
    
    SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm:ss");
    String horaFormateada = sdfHora.format(fechaHoraVenta);
%>

<div class="container my-4">
    <div class="row pb-5">
        <div>
            <div class="text-center">
                <h1>POLLOS LOCOS</h1>
                <h2>Pollería Pollos Locos S.A.C</h2>
                <h3>Av. JAVIER PRADO ESTE NRO. 6210 INT. 1201 URB. RIVERA DE MONTERRICO LA MOLINA LIMA - LIMA</h3>
                <h3>BOLETA DE VENTA ELECTRÓNICA</h3>
                <h3>${res}</h3>
                <hr>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col">
                        <p id="current-date">
                            Fecha actual:
                            <%= fechaFormateada %>
                        </p>
                        <p>DNI/RUC: ${documento}
                        </p>
                        <p class="me-3">Cliente: ${nombreDisplay}
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
                    <table class="table table-bordered text-center border border-white">
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
<%--                        <c:set var="subtotalGeneral" value="0"/>--%>
                        <c:forEach var="car" items="${carrito}">
<%--                            <c:set var="subtotalGeneral" value="${subtotalGeneral + car.getSubtotal()}"/>--%>
                            <tr>
                                <td class="align-middle">${car.getIdProducto()}</td>
                                <td class="align-middle producto">${car.getNombre()}</td>
                                <td style="text-wrap: nowrap;" class="align-middle">S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${car.getPrecio()}" /></td>
                                <td>${car.getCantidad()}</td>
                                <td class="align-middle">S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${car.getSubtotal()}" /></td>
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
                <div class="text-end">
                    <p>SubTotal: S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${totalPagar}" /></p>
                    <p>IGV (18%): S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${totalPagar * 0.18}" /></p>
                    <HR class="my-2">
                    <p style="font-weight:700">Totala Pagar: S/<fmt:formatNumber type="number" pattern="#,###,##0.00" value="${(totalPagar * 0.18) + totalPagar}" /></p>
                </div>
                
                <div class="text-center">
                    <button id="procesar-venta" onclick="print()" type="submit" class="btn btn-primary">Descargar
                        comprobante
                    </button>
                    
                    <button id="regresar" class="btn btn-secondary">
                        <a class="text-white text-decoration-none" href="<%=request.getContextPath()%>/caja/menu.jsp">
                            Regresar
                        </a>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
