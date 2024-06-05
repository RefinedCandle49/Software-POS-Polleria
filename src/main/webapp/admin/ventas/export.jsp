<%@ page import="model.Venta" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.VentaDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer">
  <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
  <title>Ventas por Fechas | Pollos Locos</title>
</head>
<body>
<%
  String desde = request.getParameter("desde");
  String hasta = request.getParameter("hasta");
  List<Venta> listaVentas = VentaDao.listarVentasPorFecha(desde, hasta);
  request.setAttribute("list", listaVentas);

%>
<h1>${desde}</h1>
<h1>${hasta}</h1>
<main class="col-auto col-10 col-sm-8 col-md-9 col-xl-10">
  <section>
    <h1 class="fw-bold">PANEL DE REPORTES</h1>
    
    <div class="d-flex align-items-center justify-content-end">
      <button class="btn btn-primary" onclick="exportTableToExcel('transactionsTable', 'SettlementTransactions')">
        Descargar EXCEL
      </button>
    </div>
    
    <c:if test="${empty list}">
      <span>¡Hola! Parece que esta tabla está vacía en este momento.</span>
    </c:if>
    
    <c:if test="${not empty list}">
      <div class="table-responsive">
        <table id="transactionsTable" class="table table-striped">
          <thead class="table-dark">
          <tr>
            <th>CÓDIGO</th>
            <th>CLIENTE</th>
            <th>MÉTODO DE PAGO</th>
            <th>FECHA Y HORA</th>
            <th>TOTAL</th>
          </tr>
          </thead>
          
          <tbody>
          <c:forEach items="${list}" var="venta">
            <tr>
              <td>${venta.getCodigo()}</td>
              <td>${venta.getNombre()} ${venta.getApellido()}</td>
              <td>
                <c:choose>
                  <c:when test="${venta.getMetodoPago() == 1}">Efectivo</c:when>
                  <c:when test="${venta.getMetodoPago() == 2}">Tarjeta</c:when>
                  <c:otherwise>Método Desconocido</c:otherwise>
                </c:choose>
              </td>
              <td>${venta.getFechaHoraVenta()}</td>
              <td>${venta.getTotal()}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>
  </section>
</main>
<script>
  function exportTableToExcel(transactionsTable, filename = ''){
    let downloadLink;
    const dataType = 'application/vnd.ms-excel';
    const tableSelect = document.getElementById(transactionsTable);
    const tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');
    
    // Specify file name
    filename = filename?filename+'.xls':'excel_data.xls';
    
    // Create download link element
    downloadLink = document.createElement("a");
    
    document.body.appendChild(downloadLink);
    
    if(navigator.msSaveOrOpenBlob){
      var blob = new Blob(['\ufeff', tableHTML], {
        type: dataType
      });
      navigator.msSaveOrOpenBlob( blob, filename);
    }else{
      // Create a link to the file
      downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
      
      // Setting the file name
      downloadLink.download = filename;
      
      //triggering the function
      downloadLink.click();
    }
  }
</script>

</body>
</html>
