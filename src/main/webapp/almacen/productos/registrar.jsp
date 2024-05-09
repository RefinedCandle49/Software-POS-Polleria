<%@ page import="dao.CategoriaDao" %>
<%@ page import="model.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrar Producto</title>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/registrar-producto.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    List<Categoria> categorias = CategoriaDao.listarCategorias();
%>
<div class="container-fluid">
    <div class="row flex-nowrap">
        <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
                
            <nav class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
                <div class="w-100 text-center text-light">
                    <span class="d-none d-sm-inline fs-6" style="opacity: 0.5">Sistema de Gestión</span>
                    <br><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                </div>

                <div class="w-100 text-center text-light">
                    <img src="${pageContext.request.contextPath}/img/user-icon.png" class="img-fluid img-css py-3" alt="..."/>
                    <br><span class="d-none d-sm-inline w-100">nombreRol</span>
                    <span class="d-none d-sm-inline w-100" style="opacity: 0.5">emailRol</span>
                </div>
                <hr>

                <ul class="nav flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">

                    <li class="nav-item pb-4">
                        <a href="${pageContext.request.contextPath}/admin/usuarios.jsp" class="link-active align-middle px-0">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-users"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" /><path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /><path d="M21 21v-2a4 4 0 0 0 -3 -3.85" /></svg>
                            <span class="ms-1 d-none d-sm-inline">Usuarios</span>
                        </a>
                    </li>

                    <li class="nav-item pb-4">
                        <a href="${pageContext.request.contextPath}/admin/ventas.jsp" class="link-inactive align-middle px-0">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-receipt-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M5 21v-16a2 2 0 0 1 2 -2h10a2 2 0 0 1 2 2v16l-3 -2l-2 2l-2 -2l-2 2l-2 -2l-3 2" /><path d="M14 8h-2.5a1.5 1.5 0 0 0 0 3h1a1.5 1.5 0 0 1 0 3h-2.5m2 0v1.5m0 -9v1.5" /></svg>
                            <span class="ms-1 d-none d-sm-inline">Ventas</span></a>
                    </li>

                    <li class="nav-item pb-4">
                        <a href="${pageContext.request.contextPath}/admin/reportes/ventas.jsp" class="link-inactive align-middle px-0">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-chart-bar"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M3 12m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v6a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M9 8m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v10a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M15 4m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" /><path d="M4 20l14 0" /></svg>
                            <span class="ms-1 d-none d-sm-inline">Reportes</span></a>
                    </li>
                </ul>
                <hr>
                <div class="pb-4">
                    <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center w-100">
                        <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                        <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                    </a>
                </div>
            </nav>
        </header>
        <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-10">
            <section>
                <h1 class="text-center">Registrar Producto</h1>
                <form action="${pageContext.request.contextPath}/controlProducto?action=registrar" method="post" enctype="multipart/form-data">
                    
                    <div class="container table-responsive">
                        <c:if test="${not empty param.mensajeError}">
                            <div id="mensajeError" class="alert alert-danger d-flex align-items-center justify-content-between">
                                    ${param.mensajeError}
                                <button type="button" class="button-mensaje text-danger" onclick="cerrarMensaje()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                            </div>
                        </c:if>
                        <table class="table mb-3">
                            <thead>
                            <tr>
                                <th>Categoría:</th>
                                <td>
                                    <select name="idCategoria" class="form-select">
                                        <% for (Categoria categoria : categorias) { %>
                                        <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getNombre() %>
                                        </option>
                                        <% } %>
                                    </select>
                                </td>
                            </tr>
                            </thead>
                            
                            <tbody>
                            <tr>
                                <th>Nombre:</th>
                                <td><input maxlength="50" type="text" name="nombre" class="form-control" required></td>
                            
                            <tr>
                                <th>Descripción:</th>
                                <td><textarea maxlength="200" name="descripcion" class="form-control" required></textarea></td>
                            </tr>
                            
                            <tr>
                                <th>Foto:</th>
                                <td>
                                    <input type="file" name="image" accept=".jpg, .jpeg, .png" required>
                                    <small>Se permiten archivos JPG y PNG de hasta 10 MB.</small>
                                </td>
                            </tr>
                            
                            <tr>
                                <th>Precio:</th>
                                <td><input type="text" name="precio" class="form-control" required onkeypress="return soloNumerosDecimales(event)"></td>
                            </tr>
                            
                            <tr>
                                <th>Stock:</th>
                                <td><input type="text" name="stock" class="form-control" required onkeypress="return soloNumeros(event)"></td>
                            </tr>
                            
                            <tr>
                                <th>Estado:</th>
                                <td>
                                    <select name="estado" class="form-select">
                                        <option value="1">Disponible</option>
                                        <option value="0">No Disponible</option>
                                    </select>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center">
                        <input type="submit" class="btn btn-dark" value="Registrar Producto">
                        <a href="${pageContext.request.contextPath}/almacen/productos.jsp" class="btn btn-primary">Regresar</a>
                    </div>
                </form>
                
            <%--    <form action="${pageContext.request.contextPath}/UploadServlet" method="post" enctype="multipart/form-data">--%>
            <%--        <input type="file" name="image">--%>
            <%--        <input type="submit" value="Subir Imagen">--%>
            <%--    </form>--%>
            </section>
        </main>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.querySelector('input[type="file"]').addEventListener('change', function() {
        const file = this.files[0];
        const maxSize = 10 * 1024 * 1024; // 10 MB en bytes

        if (file && file.size > maxSize) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'El archivo seleccionado supera el tamaño máximo permitido de 10 MB.'
            });
            this.value = ''; // Limpiar el campo de entrada
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function soloNumeros(evt){
        let charCode = (evt.which) ? evt.which : event.keyCode;
        if(charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
</script>
<script>
    function soloNumerosDecimales(evt){
        let charCode = (evt.which) ? evt.which : event.keyCode;

        // Permitir números del 0 al 9 y el punto decimal
        if(charCode !== 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }

        // Permitir solo un punto decimal
        if(charCode === 46 && evt.target.value.indexOf('.') !== -1) {
            return false;
        }

        return true;
    }
</script>
<script>
    function cerrarMensaje() {
        let mensajeError = document.getElementById("mensajeError");
        mensajeError.style.display = "none";
        window.location.href = "${pageContext.request.contextPath}/almacen/productos/registrar.jsp"
    }
</script>
</body>
</html>
