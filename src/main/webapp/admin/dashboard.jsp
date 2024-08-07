<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, model.DetalleVenta, model.Producto, model.Venta, dao.ReporteDao, java.util.*" %>
<%@ page import="dao.ProductoDao" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="dao.VentaDao" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css"/>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css"/>
    <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
    <script src="<%=request.getContextPath()%>/js/password.js"></script>
    <script src="<%=request.getContextPath()%>/js/jspdf.umd.js"></script>
    <script src="<%=request.getContextPath()%>/js/jspdf.plugin.autotable.js"></script>
    
    <title>Dashboard | Pollos Locos</title>
</head>
<body>

<%
    HttpSession sesion = request.getSession(false);
    String contextPath = request.getContextPath();
    
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    String emailRol = (String) ((Usuario) sesion.getAttribute("usuario")).getEmail();
    String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
    
    //REPORTES
    ReporteDao reporteDao = new ReporteDao();
    DetalleVenta productoMasVendido = reporteDao.obtenerProductoMasVendido();
    
    
    int clientesRegistrados = reporteDao.obtenerCantidadClientesRegistrados();
    double ingreso = reporteDao.obtenerIngresoVentas();
    
    List<DetalleVenta> detalleVenta = ReporteDao.obtenerProductosMasVendidosMes();
    request.setAttribute("list", detalleVenta);
    List<Venta> venta = ReporteDao.obtenerClienteVentasMes();
    request.setAttribute("list_clientes", venta);
    
    List<Producto> producto2 = ProductoDao.listarProductos();
    request.setAttribute("list2", producto2);
    
    if (!"Administrador".equals(nombreRol)) {
%>
<script>
    alert("Acceso Denegado");
    <%
        switch (nombreRol) {
            case "Cajero":
    %>
    window.location.href = "<%= request.getContextPath() %>/caja/menu.jsp";
    <%
                        break;
    
                        case "Almacenero":
                %>
    window.location.href = "<%= request.getContextPath() %>/almacen/productos.jsp";
    <%
                        break;
    
                        default:
                %>
    window.location.href = "<%= request.getContextPath() %>/index.jsp";
    <%
                    }
                %>
</script>
<%
        return;
    }
%>
<script>
    let contextPath = '<%= contextPath %>';
    let nombreRol = '<%= nombreRol %>';
</script>

<div class="container-fluid overflow-hidden">
    <div class="row vh-100 overflow-auto">
        <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-3 col-xxl-2 px-sm-2 px-0 bg-dark sticky-top">
            <nav
                    class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
                <div class="w-100 text-center text-light">
                            <span class="d-none d-sm-inline fs-6" style="opacity: 0.5">Sistema
                                de Gestión</span>
                    <br/><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                </div>
                
                <div class="w-100 text-center text-light">
                    <img src="${pageContext.request.contextPath}/img/user-icon.png"
                         class="img-fluid img-css py-3" alt="..."/>
                    <br/><span class="d-none d-sm-inline w-100">
                                <%= nombreRol %>
                            </span>
                    <br/><span class="d-none d-sm-inline w-100"
                               style="opacity: 0.5; word-break: break-all !important;">
                                <%= emailRol %>
                            </span>
                </div>
                <hr/>
                
                <ul class="nav flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start w-100"
                    id="menu">
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
                           class="link-active align-middle px-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                 height="24" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-chart-bar">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path
                                        d="M3 12m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v6a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z"/>
                                <path
                                        d="M9 8m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v10a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z"/>
                                <path
                                        d="M15 4m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z"/>
                                <path d="M4 20l14 0"/>
                            </svg>
                            <span class="ms-1 d-none d-sm-inline">Reportes</span>
                        </a>
                    </li>
                    <hr/>
                    
                    <li class="nav-item pb-4">
                        <a href="${pageContext.request.contextPath}/admin/usuarios.jsp?page=1"
                           class="link-inactive align-middle px-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                 height="24" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-users">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0"/>
                                <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"/>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                                <path d="M21 21v-2a4 4 0 0 0 -3 -3.85"/>
                            </svg>
                            <span class="ms-1 d-none d-sm-inline">Usuarios</span>
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/usuario/anulados.jsp?page=1"
                           class="link-inactive align-middle px-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-user-x">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"/>
                                <path d="M6 21v-2a4 4 0 0 1 4 -4h3.5"/>
                                <path d="M22 22l-5 -5"/>
                                <path d="M17 22l5 -5"/>
                            </svg>
                            <span class="ms-1 d-none d-sm-inline">Usuarios Eliminados</span>
                        </a>
                    </li>
                    <hr/>
                    
                    <li class="nav-item pb-4">
                        <a href="${pageContext.request.contextPath}/admin/ventas.jsp?page=1"
                           class="link-inactive align-middle px-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                 height="24" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2"
                                 stroke-linecap="round" stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-2">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path
                                        d="M5 21v-16a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v16l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2"/>
                                <path
                                        d="M14 8h-2.5a1.5 1.5 0 0 0 0 3h1a1.5 1.5 0 0 1 0 3h-2.5m2 0v1.5m0 -9v1.5"/>
                            </svg>
                            <span class="ms-1 d-none d-sm-inline">Ventas</span>
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/ventas-anuladas.jsp?page=1"
                           class="link-inactive align-middle px-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-off">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path d="M5 21v-16m2 -2h10a2 2 0 0 1 2 2v10m0 4.01v1.99l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2"/>
                                <path d="M11 7l4 0"/>
                                <path d="M9 11l2 0"/>
                                <path d="M13 15l2 0"/>
                                <path d="M15 11l0 .01"/>
                                <path d="M3 3l18 18"/>
                            </svg>
                            <span class="ms-1 d-none d-sm-inline">Ventas Anuladas</span>
                        </a>
                    </li>
                
                </ul>
                <hr/>
                
                <div class="pb-3">
                    <a href="${pageContext.request.contextPath}/logout.jsp"
                       class="d-flex link-active align-items-center w-100">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                             viewBox="0 0 24 24" fill="none" stroke="currentColor"
                             stroke-width="2" stroke-linecap="round"
                             stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path
                                    d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2"/>
                            <path d="M15 12h-12l3 -3"/>
                            <path d="M6 15l-3 -3"/>
                        </svg>
                        <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                    </a>
                </div>
            </nav>
        </header>
        
        <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-9 col-xxl-10 flex-column h-sm-100">
            <section>
                <h1 class="fw-bold">PANEL DE REPORTES</h1>
                
                <div class="row">
                    <div class="col-xxl-4 my-3">
                        <div class="card card-height radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body">
                                <div class="d-flex align-items-center h-100">
                                    <div>
                                        <%
                                            if (ingreso > 0) {%>
                                        <h6 class="mb-0 text-secondary">Total Ingreso</h6>
                                        <h4 class="my-1 text-report fw-bold">S/ <fmt:formatNumber type="number"
                                                                                                  pattern="#,###,##0.00"
                                                                                                  value="<%= ingreso %>"/></h4>
                                        <p class="mb-0 font-13">Ingreso anual de la empresa</p>
                                        <% } else { %>
                                        ¡Hola! Parece que no han habido ventas este año.
                                        <% } %>
                                    </div>
                                    
                                    <div class="widgets-icons-2 rounded-circle bg-gradient-ohhappiness text-white ms-auto">
                                        <i class="fa-solid fa-sack-dollar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xxl-4 my-3">
                        <div class="card card-height radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body card-res">
                                <div class="d-flex align-items-center h-100">
                                    
                                    <div>
                                        <%
                                            if (productoMasVendido != null) {%>
                                        <h6 class="mb-0 text-secondary">Producto Popular</h6>
                                        <h4 class="my-1 text-report text-responsive fw-bold"><%= productoMasVendido.getNombreProducto() %>
                                        </h4>
                                        <p class="mb-0 font-13">Producto con <%= productoMasVendido.getTotalVenta() %>
                                            ventas</p>
                                        <% } else { %>
                                        ¡Hola! Parece que no se encontró ningún producto popular.
                                        <% } %>
                                    </div>
                                    
                                    <div class="widgets-icons-2 rounded-circle bg-gradient-ohhappiness text-white ms-auto">
                                        <i class="fa-solid fa-drumstick-bite"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xxl-4 my-3">
                        <div class="card card-height radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body">
                                <div class="d-flex align-items-center h-100">
                                    
                                    <div>
                                        <%
                                            if (clientesRegistrados > 0) {%>
                                        <h6 class="mb-0 text-secondary">Total clientes</h6>
                                        <h4 class="my-1 text-report fw-bold"><%= clientesRegistrados %>
                                        </h4>
                                        <p class="mb-0 font-13">Clientes registrados en el sistema</p>
                                        <% } else { %>
                                        ¡Hola! Parece que no hay clientes registrados.
                                        <% } %>
                                    </div>
                                    
                                    <div class="widgets-icons-2 rounded-circle bg-gradient-ohhappiness text-white ms-auto">
                                        <i class="fa-solid fa-user"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-xxl-8 col-xl-12 my-3">
                        <div class="card radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body">
                                <%
                                    Gson gsonObj = new Gson();
                                    Map<Integer, String> meses = new HashMap<>();
                                    meses.put(1, "Enero");
                                    meses.put(2, "Febrero");
                                    meses.put(3, "Marzo");
                                    meses.put(4, "Abril");
                                    meses.put(5, "Mayo");
                                    meses.put(6, "Junio");
                                    meses.put(7, "Julio");
                                    meses.put(8, "Agosto");
                                    meses.put(9, "Septiembre");
                                    meses.put(10, "Octubre");
                                    meses.put(11, "Noviembre");
                                    meses.put(12, "Diciembre");
                                    Map<Object, Object> map = null;
                                    List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();
                                    
                                    List<Venta> listaVentas = VentaDao.listarVentasChart();
                                    
                                    for (Venta ventaC : listaVentas) {
                                        map = new HashMap<>();
                                        map.put("label", meses.get(ventaC.getMes())); // Usa el nombre del mes como etiqueta
                                        map.put("y", ventaC.getVentas()); // Establece el número de ventas
                                        list.add(map);
                                    }
                                    
                                    String dataPoints = gsonObj.toJson(list);
                                %>
                                <script type="text/javascript">
                                    window.onload = function () {

                                        var now = new Date();
                                        var year = now.getFullYear();

                                        var chart = new CanvasJS.Chart("chartContainer", {
                                            title: {
                                                text: "Total de ventas " + year
                                            },
                                            axisX: {
                                                title: "Meses"
                                            },
                                            axisY: {
                                                title: "Ventas",
                                                includeZero: true
                                            },
                                            data: [{
                                                type: "column",
                                                yValueFormatString: "# ventas",
                                                dataPoints: <%out.print(dataPoints);%>
                                            }]
                                        });
                                        chart.render();

                                    }
                                </script>
                                <div id="chartContainer" style="height: 370px; width: 100%;"></div>
                                <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xxl-4 col-xl-12 my-3">
                        <div class="card radius-10 border-start border-0 border-3 border-dark cont-reports"
                             style="height: 402px; width: 100%;">
                            <div class="card-body d-xxl-block d-xl-flex">
                                <div class="pe-xxl-0 pe-xl-3">
                                    <h3 class="fw-bold">VENTAS</h3>
                                    
                                    <form id="formVentas"
                                          action="<%=request.getContextPath()%>/controlDashboard?accion=buscarVentas"
                                          method="post">
                                        <label>
                                            <input required type="date" id="desde" name="desde"
                                                   max="<%= LocalDate.now() %>" class="btn"
                                                   style="background-color: #aebac1"/>
                                        </label>
                                        
                                        <label>
                                            <input required type="date" id="hasta" name="hasta"
                                                   max="<%= LocalDate.now() %>" class="btn btn-date"
                                                   style="background-color: #aebac1"/>
                                        </label>
                                        
                                        <input type="button" class="btn btn-primary btn-seleccionar" value="Seleccionar"
                                               onclick="validarFechas()"/>
                                    </form>
                                    
                                    <script>
                                        function validarFechas() {
                                            var desde = document.getElementById("desde");
                                            var hasta = document.getElementById("hasta");

                                            // Verifica si alguno de los campos está vacío
                                            if (!desde.value || !hasta.value) {
                                                Swal.fire({
                                                    icon: 'warning',
                                                    title: 'Atención',
                                                    confirmButtonColor: "#0A5ED7",
                                                    confirmButtonText: "Aceptar",
                                                    text: 'Por favor, selecciona una fecha de inicio y una fecha de fin.'
                                                });
                                            } else {
                                                var desdeDate = new Date(desde.value);
                                                var hastaDate = new Date(hasta.value);

                                                // Verifica que la fecha de inicio sea menor o igual a la fecha de fin
                                                if (desdeDate > hastaDate) {
                                                    Swal.fire({
                                                        icon: 'error',
                                                        title: 'Error',
                                                        confirmButtonColor: "#0A5ED7",
                                                        confirmButtonText: "Aceptar",
                                                        text: 'La fecha de inicio no puede ser mayor a la fecha de fin'
                                                    });
                                                } else {
                                                    document.getElementById("formVentas").submit();
                                                }
                                            }
                                        }
                                    </script>
                                </div>
                                
                                <div class="ps-xxl-0 ps-xl-3">
                                    <h3 class="fw-bold">PRODUCTOS</h3>
                                    
                                    <c:if test="${empty list2}">
                                        <span>No hay productos disponibles en el sistema.</span>
                                    </c:if>
                                    
                                    <c:if test="${not empty list2}">
                                        <div class="">
                                            <button class="btn btn-primary mx-1" onclick="generatePDF()">Descargar PDF
                                                Inventario
                                            </button>
                                        </div>
                                        
                                        <table style="display: none" id="tableProducts" class="table mb-0">
                                            <thead class="table-dark">
                                            <tr>
                                                <th style="display: none">ID</th>
                                                <th>CÓDIGO</th>
                                                <th>CATEGORÍA</th>
                                                <th>NOMBRE</th>
                                                <th>DESCRIPCIÓN</th>
                                                <th>PRECIO</th>
                                                <th>STOCK</th>
                                            
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${list2}" var="prod">
                                                <tr>
                                                    <td style="display: none">${prod.getIdProducto()}</td>
                                                    <td>${prod.getCodigo()}</td>
                                                    <td>${prod.getNombreCategoria()}</td>
                                                    <td>${prod.getNombre()}</td>
                                                    <td>${prod.getDescripcion()}</td>
                                                    
                                                    
                                                    <td style="text-wrap: nowrap;">S/ <fmt:formatNumber type="number"
                                                                                                        pattern="#,###,##0.00"
                                                                                                        value="${prod.getPrecio()}"/></td>
                                                    <td>${prod.getStock()}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                    
                                    
                                    <script>
                                        function generatePDF() {
                                            var date = new Date();
                                            var formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0') + ' ' + date.getHours().toString().padStart(2, '0') + '-' + date.getMinutes().toString().padStart(2, '0') + '-' + date.getSeconds().toString().padStart(2, '0');
                                            var filename = "Almacen - " + formattedDate + ".pdf";
                                            var doc = new jspdf.jsPDF()
                                            doc.setPage(1);
                                            doc.text("Stock productos disponibles: ", 10, 10);

                                            // Simple html example
                                            doc.autoTable({html: '#tableProducts'});
                                            doc.save(filename)
                                        }
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-xxl-6 my-3">
                        <div class="card card-height-table radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body bg-white rounded-3 table-responsive">
                                <h6 class="card-subtitle mb-2 text-secondary">Productos más vendidos del mes</h6>
                                
                                <c:if test="${ empty list}">
                                    <span>¡Hola! Parece que no han habido ventas en este mes.</span>
                                    <div class="d-flex justify-content-center align-items-center w-100 my-1">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="icon icon-tabler icons-tabler-outline icon-tabler-calendar-off"
                                             style="opacity: 0.5">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <path d="M9 5h9a2 2 0 0 1 2 2v9m-.184 3.839a2 2 0 0 1 -1.816 1.161h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 1.158 -1.815"/>
                                            <path d="M16 3v4"/>
                                            <path d="M8 3v1"/>
                                            <path d="M4 11h7m4 0h5"/>
                                            <path d="M3 3l18 18"/>
                                        </svg>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty list}">
                                    <table class="table m-0">
                                        <thead>
                                        <tr>
                                            <th style="display: none">ID</th>
                                            <th>ÍTEM</th>
                                            <th>SKU</th>
                                            <th>PRODUCTO</th>
                                            <th>N° VENTAS</th>
                                            <th>MES</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${list}" var="dev" varStatus="loop">
                                            <tr>
                                                <td style="display: none">${dev.getIdProducto()}</td>
                                                <td>${loop.index + 1}</td>
                                                <td>${dev.getCodigo()}</td>
                                                <td>${dev.getNombreProducto()}</td>
                                                <td>${dev.getCantidadVendida()}</td>
                                                <td>${dev.getNombreMesActual()}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xxl-6 my-3">
                        <div class="card card-height-table radius-10 border-start border-0 border-3 border-dark">
                            <div class="card-body bg-white rounded-3 table-responsive">
                                <h6 class="card-subtitle mb-2 text-secondary">Clientes más recurrentes del mes</h6>
                                
                                <c:if test="${ empty list_clientes}">
                                    <span>¡Hola! Parece que no han habido ventas en este mes.</span>
                                    <div class="d-flex justify-content-center align-items-center w-100 my-1">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="icon icon-tabler icons-tabler-outline icon-tabler-calendar-off"
                                             style="opacity: 0.5">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <path d="M9 5h9a2 2 0 0 1 2 2v9m-.184 3.839a2 2 0 0 1 -1.816 1.161h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 1.158 -1.815"/>
                                            <path d="M16 3v4"/>
                                            <path d="M8 3v1"/>
                                            <path d="M4 11h7m4 0h5"/>
                                            <path d="M3 3l18 18"/>
                                        </svg>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty list_clientes}">
                                    <table class="table m-0">
                                        <thead>
                                        <tr>
                                            <th style="display: none">ID</th>
                                            <th>ÍTEM</th>
                                            <th>DOC.</th>
                                            <th>NOMBRE</th>
                                            <th>N° VENTAS</th>
                                            <th>MES</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${list_clientes}" var="vt" varStatus="loop">
                                            <tr>
                                                <td style="display: none">${vt.getIdCliente()}</td>
                                                <td>${loop.index + 1}</td>
                                                <td>${vt.getDocumento()}</td>
                                                <td>${vt.getNombreCliente()}</td>
                                                <td>${vt.getCantidadVentas()}</td>
                                                <td>${vt.getNombreMesActual()}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function alertBienvenida() {
        const url = new URLSearchParams(window.location.search);
        const alert = url.get('alert');

        if (alert === 'true') {
            Swal.fire({
                icon: "success",
                title: 'Bienvenido, ' + nombreRol,
                confirmButtonColor: "#0A5ED7",
                confirmButtonText: "Aceptar",
                allowOutsideClick: false
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = contextPath + "/admin/dashboard.jsp?alert=false";
                }
            });
        }
    }

    alertBienvenida()
</script>
</body>
</html>
