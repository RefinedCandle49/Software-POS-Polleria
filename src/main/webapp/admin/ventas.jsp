<%@ page import="dao.VentaDao" %>
<%@ page import="model.Venta" %>
<%@ page import="java.util.List" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Ventas</title>
</head>
<body>
    <%
        List<Venta> milista = VentaDao.listarVentas();
        request.setAttribute("list", milista);
    %>
    <%--Tabla con las últimas ventas hechas, con la opción de poder descargar la boleta de venta en PDF como también poder anular una mediante botones--%>
    
    <%-- TABLA GENERAL --%>
    <c:if test="${not empty list}">
        <h3 class="text-center mt-4 mb-2">TABLA GENERAL</h3>
        <div class="table-responsive-md">
            <main>
                <table class="table container" border="1">
                <thead class="table-dark">
                <tr>
                    <th class="text-center">ID</th>
                    <th class="text-center">CLIENTE</th>
                    <th class="text-center">METODO DE PAGO</th>
                    <th class="text-center">HORA</th>
                    <th class="text-center">TOTAL</th>
                    <th></th>
                    
                </tr>
                </thead>
                
                <tbody>
                
                
                
                <c:forEach items="${list}" var="venta">
                    <tr>
                        <td class="text-center">${venta.getIdVenta()}</td>
                        <td class="text-center">${venta.getNombre()} ${venta.getApellido()}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${venta.getMetodoPago() == 1}">Efectivo</c:when>
                                <c:when test="${venta.getMetodoPago() == 2}">Tarjeta</c:when>
                                <c:otherwise>Método Desconocido</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">${venta.getHoraVenta()}</td>
                        <td class="text-center">${venta.getTotal()}</td>
                        
                        <!-- <td>
                            <form action="${pageContext.request.contextPath}/ControlPedido"
                                  method="post">
                                <input type="hidden" name="idPedido" value="${venta.getIdVenta()}">
                                <input type="hidden" name="newEstado" value="4">
                                  <div class="d-grid gap-2 col-12 mx-auto">
                                    <button class="align-middle btn btn-danger" type="submit">Cancelar
                                </button>
                                </div> 
                            </form>
                        </td> -->
                        <td class="text-center"><a href="${pageContext.request.contextPath}/admin/ventas/comprobante.jsp?idVenta=${venta.getIdVenta()}"><i class="mt-2 fa-solid fa-eye fa-xl" style="color: #000000"></i></a></td>
                        
                        <!--  <td>
                            <a class="col-12 mx-auto align-middle btn btn-secondary" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${venta.getIdVenta()}">
                               Más Detalles</a>
                        </td> -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </main>
        </div>
    </c:if>
    </body>
</html>
