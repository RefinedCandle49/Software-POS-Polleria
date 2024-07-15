<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<%@ page import="dao.CategoriaDao" %>
<%@ page import="model.Categoria" %>
<html>
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/registrar-producto.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css" />
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
        <title>Actualizar Producto | Pollos Locos</title>
    </head>
    <body>
        <%
                    HttpSession sesion = request.getSession(false);
                    String contextPath = request.getContextPath();
            
                    if (sesion == null || sesion.getAttribute("usuario") == null) {
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                        System.out.println("Sin sesion");
                        return;
                    }
            
                    String emailRol = (String) ((Usuario) sesion.getAttribute("usuario")).getEmail();
                    String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
                    if(!"Almacenero".equals(nombreRol)){    
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Cajero":
            %>window.location.href = "<%= request.getContextPath() %>/caja/menu.jsp";<%
                    break;
                    
                case "Administrador":
            %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp";<%
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
        <script>
            let contextPath = '<%= contextPath %>';
            let nombreRol = '<%= nombreRol %>';
        </script>
        <%
            List<Categoria> categorias = CategoriaDao.listarCategorias();
        %>
        <div class="container-fluid overflow-hidden">
            <div class="row flex-nowrap vh-100 overflow-hidden">
                <header class="col-auto col-2 col-sm-4 col-md-3 col-xl-3 col-xxl-2 px-sm-2 px-0 bg-dark sticky-top">
                    <nav class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 min-vh-100">
                        <div class="w-100 text-center text-light">
                            <span class="d-none d-sm-inline fs-6" style="opacity: 0.5">Sistema de Gestión</span>
                            <br><span class="d-none d-sm-inline fs-4 w-100">POLLOS LOCOS</span>
                        </div>

                        <div class="w-100 text-center text-light">
                            <img src="${pageContext.request.contextPath}/img/user-icon.png" class="img-fluid img-css py-3" alt="..."/>
                            <br /><span class="d-none d-sm-inline w-100"><%= nombreRol %></span>
                            <br /><span class="d-none d-sm-inline w-100" style="opacity: 0.5; word-break: break-all !important;"><%= emailRol %></span>
                        </div>
                        <hr>

                            <ul class="nav flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
                                <li class="nav-item pb-4">
                                    <a href="${pageContext.request.contextPath}/almacen/productos.jsp?page=1" class="link-inactive align-middle px-0">
                                        <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-meat"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13.62 8.382l1.966 -1.967a2 2 0 1 1 3.414 -1.415a2 2 0 1 1 -1.413 3.414l-1.82 1.821" /><path d="M5.904 18.596c2.733 2.734 5.9 4 7.07 2.829c1.172 -1.172 -.094 -4.338 -2.828 -7.071c-2.733 -2.734 -5.9 -4 -7.07 -2.829c-1.172 1.172 .094 4.338 2.828 7.071z" /><path d="M7.5 16l1 1" /><path d="M12.975 21.425c3.905 -3.906 4.855 -9.288 2.121 -12.021c-2.733 -2.734 -8.115 -1.784 -12.02 2.121" /></svg>
                                        <span class="ms-1 d-none d-sm-inline">Productos Disponibles</span>
                                    </a>
                                </li>

                                <li class="pb-4">
                                    <a href="${pageContext.request.contextPath}/almacen/productos/anulados.jsp?page=1" class="link-inactive align-middle px-0">
                                        <!--  <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                                        -->  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="20"  height="20"><path fill="#ffffff" d="M367.2 412.5L99.5 144.8C77.1 176.1 64 214.5 64 256c0 106 86 192 192 192c41.5 0 79.9-13.1 111.2-35.5zm45.3-45.3C434.9 335.9 448 297.5 448 256c0-106-86-192-192-192c-41.5 0-79.9 13.1-111.2 35.5L412.5 367.2zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256z"/></svg>
                                        <span class="ms-1 d-none d-sm-inline">Productos No Disponibles</span>
                                    </a>
                                </li>
                            </ul>
                            <hr />
                            <div class="pb-3">
                                <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center w-100">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                                    <span class="d-none d-sm-inline mx-1">Cerrar Sesión</span>
                                </a>
                            </div>
                    </nav>
                </header>

                <main class="col-auto col-10 col-sm-8 col-md-9 col-xl-9 col-xxl-10 flex-column h-sm-100">
                    <section>
                        <form action="${pageContext.request.contextPath}/controlProducto?action=actualizar" method="post" enctype="multipart/form-data" onsubmit="trimInputs()"> 

                            <h1 class="text-center fw-bold mb-5">ACTUALIZACIÓN DE PRODUCTO</h1>
                            <div class="container">


                                <input type="hidden" name="idProducto" value="${param.idProducto != null ? param.idProducto : producto.idProducto}" />
                                <input type="hidden" name="view" value="${param.view}"/>   

                                <div class="fw-bold text-dark">

                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-8">
                                            <c:if test="${not empty mensajeError}">
                                                <div id="mensajeError" class="alert alert-danger d-flex align-items-center justify-content-between fw-normal">
                                                    ${mensajeError}       
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="col-sm-4"></div>
                                    </div>

                                    <div class="mb-3 row">

                                        <div class="col-sm-2"></div>
                                        <label for="categoria" class="col-sm-1 col-form-label">Categoria:</label>
                                        <div class="col-sm-7">
                                            <select name="idCategoria" class="form-select" required>
                                                <option value="1" ${producto.idCategoria == 1 ? "selected" : producto.idCategoria}>Pollos</option>
                                                <option value="2" ${producto.idCategoria == 2 ? "selected" : producto.idCategoria}>Sopas</option>
                                                <option value="3" ${producto.idCategoria == 3 ? "selected" : producto.idCategoria}>Bebidas</option>
                                                <option value="4" ${producto.idCategoria == 4 ? "selected" : producto.idCategoria}>Postres</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="codigo" class="col-sm-1 col-form-label">SKU:</label>
                                        <div class="col-sm-7">
                                            <input type="text" name="codigo" class="form-control" id="codigo" value="${param.codigo != null ? param.codigo : producto.codigo}" readonly style="background: #e9ecef;">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="nombre" class="col-sm-1 col-form-label">Nombre:</label>
                                        <div class="col-sm-7">
                                            <input type="text" name="nombre" class="form-control" id="nombre" value="${param.nombre != null ? param.nombre : producto.nombre}" required onkeypress="return validarEspacios(event)">
                                                <span id="errorNombre" class="text-danger fw-normal"></span>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="descripcion" class="col-sm-1 col-form-label">Descripcion:</label>
                                        <div class="col-sm-7">
                                            <textarea type="text" name="descripcion" class="form-control" id="descripcion" required onkeypress="return validarEspacios(event)">${param.descripcion != null ? param.descripcion : producto.descripcion}</textarea>
                                            <span id="errorDescripcion" class="text-danger fw-normal"></span>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="foto" class="col-sm-1 col-form-label">Foto:</label>
                                        <div class="col-sm-7">                                                                                                              
                                            <input type="file" name="image" accept=".jpg, .jpeg, .png" id="image" class="btn-file" />
                                            <input type="hidden" name="foto" id="foto" value="${param.foto != null ? param.foto : producto.foto}" />
                                            <small class="fw-normal">Se permiten archivos JPG y PNG de hasta 10 MB.</small>
                                        </div>
                                    </div>   
                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="precio" class="col-sm-1 col-form-label">Precio:</label>
                                        <div class="col-sm-7">                                                                                                              
                                            <input type="number" name="precio" id="precio" min="1" max="999.99" step="any" pattern="^\d*(\.\d{0,2})?$" class="form-control" value="${param.precio != null ? param.precio : producto.precio}" required onkeypress="return soloNumerosDecimales(event)">
                                                <span id="errorSoloNumDecimales" class="text-danger fw-normal"></span>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="stock" class="col-sm-1 col-form-label">Stock:</label>
                                        <div class="col-sm-7">
                                            <input type="text" maxlength="3" name="stock" class="form-control" id="stock" value="${param.stock != null ? param.stock : producto.stock}" required onkeypress="return soloNumeros(event)">
                                                <span id="errorSoloNumeros" class="text-danger fw-normal"></span>
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <div class="col-sm-2"></div>
                                        <label for="stock" class="col-sm-1 col-form-label">Estado:</label>
                                        <div class="col-sm-7">
                                            <select name="estado" class="form-select">
                                                <option value="1" ${producto.estado == 1 ? "selected" : producto.estado}>Disponible</option>
                                                <option value="0" ${producto.estado == 0 ? "selected" : producto.estado}>No Disponible</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-success">Guardar Cambios</button>
                                        <a href="javascript:history.back()" class="btn btn-secondary">Regresar</a>
                                    </div>
                                </div>   
                            </div>
                        </form>

                    </section>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.querySelector('input[type="file"]').addEventListener('change', function () {
                const file = this.files[0];
                const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
                const maxSize = 10 * 1024 * 1024; // 10 MB en bytes

                if (file) {
                    if (!allowedTypes.includes(file.type)) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Solo se admiten archivos JPG, JPEG y PNG.',
                            confirmButtonColor: "#0d6efd",
                            confirmButtonText: "Aceptar"
                        });
                        this.value = ''; // Limpiar el campo de entrada
                    } else if (file.size > maxSize) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'El archivo seleccionado supera el tamaño máximo permitido de 10 MB.',
                            confirmButtonColor: "#0d6efd",
                            confirmButtonText: "Aceptar"
                        });
                        this.value = ''; // Limpiar el campo de entrada
                    }
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function soloNumeros(evt) {
                let charCode = (evt.which) ? evt.which : event.keyCode;
                let mensajeVal = document.getElementById("errorSoloNumeros");
                let inputStk = document.getElementById("stock");

                mensajeVal.textContent = "";
                inputStk.style.border = "1px solid #dee2e6";

                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    mensajeVal.textContent = "Solo se permiten números.";
                    inputStk.style.border = "1px solid red";
                    return false;
                }
                return true;
            }
        </script>
        <script>
            function soloNumerosDecimales(evt) {
                let charCode = (evt.which) ? evt.which : event.keyCode;
                let mensajeVal = document.getElementById("errorSoloNumDecimales");
                let inputPrec = document.getElementById("precio");

                mensajeVal.textContent = "";
                inputPrec.style.border = "1px solid #dee2e6";

                if ((charCode > 47 && charCode < 58) || charCode === 46) {
                    let input = evt.target.value + String.fromCharCode(charCode);
                    if (/^\d*\.?\d{0,2}$/.test(input)) {
                        return true;
                    } else {
                        mensajeVal.textContent = "Solo se permiten dos números luego del punto decimal.";
                        inputPrec.style.border = "1px solid red";
                        return false;
                    }
                } else {
                    mensajeVal.textContent = "Solo se permiten números y punto decimal.";
                    inputPrec.style.border = "1px solid red";
                    return false;
                }
            }
        </script>

        <script>
            function validarEspacios(evt) {
                let input = evt.target;
                let mensajeVal;

                if (input.id === "nombre") {
                    mensajeVal = document.getElementById("errorNombre");
                } else if (input.name === "descripcion") {
                    mensajeVal = document.getElementById("errorDescripcion");
                }

                let valor = input.value.trim() + String.fromCharCode(evt.which ? evt.which : evt.keyCode);

                mensajeVal.textContent = "";
                input.style.border = "1px solid #dee2e6";

                if (valor.trim().length === 0) {
                    mensajeVal.textContent = "El campo no puede contener solo espacios";
                    input.style.border = "1px solid red";
                    return false;
                }
                return true;
            }

            function trimInputs() {
              let inputs = document.querySelectorAll('input[type="text"], textarea');
              inputs.forEach(input => {
              input.value = input.value.trim();
              });
              }

              document.querySelector("form").addEventListener("submit", function(event) {
              trimInputs();
              if (!validarCaracteres()) {
              event.preventDefault();
              }
              });
        

        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>