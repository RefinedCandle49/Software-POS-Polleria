<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, model.Venta, dao.VentaDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
                  integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
                  crossorigin="anonymous" referrerpolicy="no-referrer" />
            <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
            <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css" />
            <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
            <title>Ventas | Pollos Locos</title>
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
            
                if(!"Administrador".equals(nombreRol)){    
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Cajero":
            %>window.location.href = "<%= request.getContextPath() %>/caja/menu.jsp";<%
                    break;
                    
                case "Almacenero":
            %>window.location.href = "<%= request.getContextPath() %>/almacen/productos.jsp";<%
                    break;
                    
                    default:
            %>window.location.href = "<%= request.getContextPath() %>/index.jsp";<%
            }
            %>
        </script>
        <%
            
            return;
        }
        %>
        <%
            String spageid=request.getParameter("page");
            int pageid=Integer.parseInt(spageid);
            int total=14;
            if(pageid==1){}
            else{
                pageid=pageid-1;
                pageid=pageid*total+1;
            }
            List<Venta> venta = VentaDao.listarVentasPagina(pageid,total);
            request.setAttribute("list", venta);
            
            int totalClientes = VentaDao.contarVentas();
            int totalPages = (int) Math.ceil((double) totalClientes / total); // Calcula el número total de páginas
        %>

        <div class="container-fluid overflow-hidden">
            <div class="row vh-100 overflow-auto">
                <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-3 col-xxl-2 px-sm-2 px-0 bg-dark sticky-top">
                    <nav class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
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
                                   class="link-inactive align-middle px-0">
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

                            <li class="nav-item pb-4">
                                <a href="${pageContext.request.contextPath}/admin/usuarios.jsp?page=1"
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

                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/usuario/anulados.jsp?page=1"
                                   class="link-inactive align-middle px-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-user-x">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                                        <path d="M6 21v-2a4 4 0 0 1 4 -4h3.5" />
                                        <path d="M22 22l-5 -5" />
                                        <path d="M17 22l5 -5" />
                                    </svg>
                                    <span class="ms-1 d-none d-sm-inline">Usuarios Eliminados</span>
                                </a>
                            </li>
                            <hr />

                            <li class="nav-item pb-4">
                                <a href="${pageContext.request.contextPath}/admin/ventas.jsp?page=1"
                                   class="link-active align-middle px-0">
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
                                <a href="${pageContext.request.contextPath}/admin/ventas-anuladas.jsp?page=1"
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
                        <h1 class="fw-bold">PANEL DE VENTAS</h1>

                        <c:if test="${empty list}">
                            <span>¡Hola! Parece que esta tabla está vacía en este momento.</span>
                        </c:if>

                        <c:if test="${not empty list}">
                            <div class="table-responsive bg-light color-tabla callout my-2 pb-0">
                                <table class="table mb-0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th style="display: none">ID</th>
                                            <th>CÓDIGO</th>
                                            <th>CLIENTE</th>
                                            <th>FECHA Y HORA</th>
                                            <th>TOTAL</th>
                                            <th>MÁS DETALLES</th>
                                            <th>ACCIONES</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach items="${list}" var="venta">
                                            <tr>
                                                <td style="display: none">${venta.getIdVenta()}</td>
                                                <td>${venta.getCodigo()}</td>
                                                <td>${venta.getNombre()} ${venta.getApellido()}</td>
                                                <td>${venta.getFechaHoraVenta()}</td>
                                                <td>S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${venta.getTotal()}" /></td>


                                                <td><a href="${pageContext.request.contextPath}/admin/ventas/comprobante.jsp?idVenta=${venta.getIdVenta()}"><i class="mt-2 fa-solid fa-eye fa-xl" style="color: #000000"></i></a></td>

                                                <td>

                                                    <button id="btnAnular${venta.getIdVenta()}" data-form-id="formAnular${venta.getIdVenta()}" class="btn btn-danger d-flex align-items-center">
                                                        <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-trash"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M4 7l16 0" /><path d="M10 11l0 6" /><path d="M14 11l0 6" /><path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" /><path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" /></svg>
                                                        <span class="ms-1">Anular</span>
                                                    </button>

                                                    <form id="formAnular${venta.getIdVenta()}" action="${pageContext.request.contextPath}/controlVenta" method="post" class="m-0">
                                                        <input type="hidden" name="idVenta" value="${venta.getIdVenta()}" />
                                                        <input type="hidden" name="newEstado" value="0" />
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-center">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/ventas.jsp?page=1" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <%
                                        for(int i = 1; i <= totalPages; i++) {
                                    %>
                                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/ventas.jsp?page=<%=i%>"><%=i%></a></li>
                                        <% } %>
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/ventas.jsp?page=<%=totalPages%>" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:if>
                    </section>           
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                document.addEventListener('DOMContentLoaded', function () {

                    let btnAnular = document.querySelectorAll('[id^="btnAnular"]');

                    btnAnular.forEach(function (btn) {
                        btn.addEventListener('click', function () {

                            let formId = this.getAttribute('data-form-id');

                            Swal.fire({
                                title: "¿Está seguro?",
                                html: "Esta acción anulará definitivamente está venta.",
                                icon: "warning",
                                showCancelButton: true,
                                confirmButtonColor: "#0d6efd", //#3085d6
                                cancelButtonColor: "#dc3545", //#d33
                                cancelButtonText: "Cancelar",
                                confirmButtonText: "Confirmar"
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    document.getElementById(formId).submit();
                                }
                            });
                        });
                    });

                    const urlParams = new URLSearchParams(window.location.search);
                    const anularVenta = urlParams.get('anularVenta');

                    if (anularVenta === 'true') {
                        Swal.fire({
                            title: 'Venta anulada correctamente',
                            icon: 'success',
                            confirmButtonColor: "#0d6efd",
                            confirmButtonText: 'Aceptar'
                        }).then(() => {
                            window.location.href = "<%= request.getContextPath() %>/admin/ventas.jsp?page=1"
                        });
                    }
                });
        </script>
    </body>
</html>
