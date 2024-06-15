<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, model.DetalleVenta, model.Producto, dao.ReporteDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css" />
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico" />
        <script src="<%=request.getContextPath()%>/js/password.js"></script>
        <title>Dashboard | Pollos Locos</title>
    </head>
    <body>
        <% 
            HttpSession sesion=request.getSession(false); 
            String contextPath=request.getContextPath(); 
            
            if (sesion==null || sesion.getAttribute("usuario")==null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp" ); return; 
            }
            
            String emailRol=(String) ((Usuario) sesion.getAttribute("usuario")).getEmail(); 
            String nombreRol=(String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
            //REPORTES
            ReporteDao reporteDao = new ReporteDao();
            DetalleVenta productoMasVendido = reporteDao.obtenerProductoMasVendido(2024);
            
            
            if(!"Administrador".equals(nombreRol)){
        %>
        <script>
            alert("Acceso Denegado");
            <%
                switch (nombreRol) {
                    case "Cajero":
            %> window.location.href = "<%= request.getContextPath() %>/caja/menu.jsp";<%
                    break;

                    case "Almacenero":
            %> window.location.href = "<%= request.getContextPath() %>/almacen/productos.jsp";<%
                    break;

                    default:
            %> window.location.href = "<%= request.getContextPath() %>/index.jsp";<%
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
                            <br /><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                        </div>

                        <div class="w-100 text-center text-light">
                            <img src="${pageContext.request.contextPath}/img/user-icon.png"
                                 class="img-fluid img-css py-3" alt="..." />
                            <br /><span class="d-none d-sm-inline w-100">
                                <%= nombreRol %>
                            </span>
                            <br /><span class="d-none d-sm-inline w-100"
                                        style="opacity: 0.5; word-break: break-all !important;">
                                <%= emailRol %>
                            </span>
                        </div>
                        <hr />

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
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path
                                            d="M3 12m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v6a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                                        <path
                                            d="M9 8m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v10a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                                        <path
                                            d="M15 4m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                                        <path d="M4 20l14 0" />
                                    </svg>
                                    <span class="ms-1 d-none d-sm-inline">Reportes</span>
                                </a>
                            </li>
                            <hr />

                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/usuarios.jsp"
                                   class="link-inactive align-middle px-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                         height="24" viewBox="0 0 24 24" fill="none"
                                         stroke="currentColor" stroke-width="2"
                                         stroke-linecap="round" stroke-linejoin="round"
                                         class="icon icon-tabler icons-tabler-outline icon-tabler-users">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" />
                                        <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                        <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                        <path d="M21 21v-2a4 4 0 0 0 -3 -3.85" />
                                    </svg>
                                    <span class="ms-1 d-none d-sm-inline">Usuarios</span>
                                </a>
                            </li>
                            <hr />

                            <li class="nav-item pb-4">
                                <a href="${pageContext.request.contextPath}/admin/ventas.jsp"
                                   class="link-inactive align-middle px-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                         height="24" viewBox="0 0 24 24" fill="none"
                                         stroke="currentColor" stroke-width="2"
                                         stroke-linecap="round" stroke-linejoin="round"
                                         class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-2">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path
                                            d="M5 21v-16a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v16l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2" />
                                        <path
                                            d="M14 8h-2.5a1.5 1.5 0 0 0 0 3h1a1.5 1.5 0 0 1 0 3h-2.5m2 0v1.5m0 -9v1.5" />
                                    </svg>
                                    <span class="ms-1 d-none d-sm-inline">Ventas</span>
                                </a>
                            </li>

                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/ventas-anuladas.jsp"
                                   class="link-inactive align-middle px-0">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-off"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M5 21v-16m2 -2h10a2 2 0 0 1 2 2v10m0 4.01v1.99l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2" /><path d="M11 7l4 0" /><path d="M9 11l2 0" /><path d="M13 15l2 0" /><path d="M15 11l0 .01" /><path d="M3 3l18 18" /></svg>
                                    <span class="ms-1 d-none d-sm-inline">Ventas Anuladas</span>
                                </a>
                            </li>

                        </ul>
                        <hr />

                        <div class="pb-3">
                            <a href="${pageContext.request.contextPath}/logout.jsp"
                               class="d-flex link-active align-items-center w-100">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                     viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                     stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round"
                                     class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                    <path
                                        d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" />
                                    <path d="M15 12h-12l3 -3" />
                                    <path d="M6 15l-3 -3" />
                                </svg>
                                <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                            </a>
                        </div>
                    </nav>
                </header>

                <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-9 col-xxl-10 flex-column h-sm-100">
                    <section>
                        <h1 class="fw-bold">PANEL DE REPORTES</h1>

                        <section class="ventas-por-fechas">
                            <h3 class="fw-bold">VENTAS</h3>
                            
                            <form id="formVentas" action="<%=request.getContextPath()%>/controlDashboard?accion=buscarVentas" method="post">
                                <label>
                                    <input required type="date" id="desde" name="desde" max="<%= LocalDate.now() %>" class="btn" style="background-color: #aebac1"/>
                                </label>
                                
                                <label>
                                    <input required type="date" id="hasta" name="hasta" max="<%= LocalDate.now() %>" class="btn" style="background-color: #aebac1"/>
                                </label>
                                
                                <input type="button" class="btn btn-primary" value="Seleccionar" onclick="validarFechas()" />
                            </form>
                            
                            <script>
                                function validarFechas() {
                                    var desde = new Date(document.getElementById("desde").value);
                                    var hasta = new Date(document.getElementById("hasta").value);

                                    if (desde > hasta) {
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
                            </script>
                        </section>

                        <section class="otros-reportes">
                            <h3 class="fw-bold">OTROS REPORTES</h3>

                            <div class="row justify-content-between">

                                <div class="col-sm-4 my-3">
                                    <div class="card">
                                        <div class="card-body bg-white rounded-3">
                                            <h6 class="card-subtitle mb-3 text-muted">PRODUCTO MÁS POPULAR DEL AÑO</h6>
                                            <%
                                if(productoMasVendido != null) {%>
                                            <h4 class="card-title text-center fw-bold m-0"><%= productoMasVendido.getNombreProducto() %></h4>
                                            <p class="card-text text-center text-success fw-bold">
                                                <span class="fs-1"><%= productoMasVendido.getTotalVenta() %></span>
                                                <span class="fs-5">‎ ventas</span>
                                            </p>
                                            <% } else { %>
                                            No se encontró ningún producto popular.
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                        
                            </div>
                        </section>
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
