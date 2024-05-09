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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
    <title>Title</title>
</head>
<body>
<%
    List<Venta> milista = VentaDao.listarVentas();
    request.setAttribute("list", milista);
%>
<%--Tabla con las últimas ventas hechas, con la opción de poder descargar la boleta de venta en PDF como también poder anular una mediante botones--%>

<%-- TABLA GENERAL --%>
<c:if test="${not empty list}">
    <h3 class="mt-4 mb-2">TABLA GENERAL</h3>
    <div class="table-responsive-md">
        <table class="table table-bordered container" border="1">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>CLIENTE</th>
                <th>METODO DE PAGO</th>
                <th>HORA</th>
                <th>TOTAL</th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            
            <tbody>
            
            
            
            <c:forEach items="${list}" var="venta">
                <tr>
                    <td>${venta.getIdVenta()}</td>
                    <td>${venta.getNombre()} ${venta.getApellido()}</td>
                    <td>
                        <c:choose>
                            <c:when test="${venta.getMetodoPago() == 0}">Efectivo</c:when>
                            <c:when test="${venta.getMetodoPago() == 1}">Tarjeta</c:when>
                            <c:otherwise>Método Desconocido</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${venta.getHoraVenta()}</td>
                    <td>${venta.getTotal()}</td>
                    
                    <td>
                        <form action="${pageContext.request.contextPath}/ControlPedido"
                              method="post">
                            <input type="hidden" name="idPedido" value="${venta.getIdVenta()}">
                            <input type="hidden" name="newEstado" value="4">
                            <button class="btn btn-danger btn-sm" type="submit">Cancelar
                            </button>
                        </form>
                    </td>
                    <td><a href="${pageContext.request.contextPath}/admin/ventas/comprobante.jsp?idVenta=${venta.getIdVenta()}"><i class="fa-solid fa-eye fa-xl" style="color: #59e656;"></i></a></td>
                    
                    <td>
                        <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${venta.getIdVenta()}">
                            Más Detalles</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>
</body>
</html>
