<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, model.Cliente, dao.ClienteDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer">
        <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/carrito.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
        <title>Carrito | Pollos Locos</title>
    </head>
    <body id="grid">
        <%
            HttpSession sesion = request.getSession(false);
            
            if (sesion == null || sesion.getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
            if(!"Cajero".equals(nombreRol)){
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Administrador":
            %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp";<%
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
        <div></div>
        <div class="container-fluid my-4">
            <div class="row pb-5">
                <c:if test="${totalPagar > 0}">
                    <form action="<%=request.getContextPath()%>/controlCarrito?accion=RealizarVenta" method="post"
                          id="ventaForm">
                        <div>
                            <div class="">
                                <div class="text-center printed">
                                    <h1>POLLOS LOCOS</h1>
                                    <h2>Pollería Pollos Locos S.A.C</h2>
                                    <h3>Av. JAVIER PRADO ESTE NRO. 6210 INT. 1201 URB. RIVERA DE MONTERRICO LA MOLINA LIMA - LIMA</h3>
                                    <H3>BOLETA DE VENTA ELECTRÓNICA</H3>
                                    <HR>
                                </div>


                                <div class="row">
                                    <div class="col">
                                        <p id="current-date"></p>
                                        <p>NoCaja: 4251</p>
                                        <p><label style="white-space: nowrap;">
                                                DNI/RUC:
                                                <input maxlength="11" type="text" id="idCliente" name="idCliente"
                                                       placeholder="Ingrese ID del Cliente" onkeypress="return soloNumeros(event)"
                                                       value="00000001">
                                            </label></p>
                                        <p><label>
                                                Cliente:
                                                <input type="text" id="nombreDisplay" name="nombreDisplay" required>
                                            </label></p>
                                    </div>
                                    <div class="col">
    
                                        <input type="hidden" id="FechaHoraActual" name="FechaHoraActual">
    
                                        <p id="current-time"></p>
                                        
                                        <p>Tda No. : 227</p>
                                    </div>

                                </div>
                                <div>

                                </div>

                                <button type="button" class="btn btn-primary" id="buscar">Buscar Cliente</button>
                                <button type="button" class="btn btn-secondary" id="limpiar">Limpiar</button>
                                <button type="button" class="btn btn-primary" id="generico">Genérico</button>
                            </div>
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
                                    <c:forEach var="car" items="${carrito}">
                                        <tr>
                                            <td class="align-middle">${car.getIdProducto()}</td>
                                            <td class="align-middle producto">${car.getNombre()}</td>
                                            <td style="text-wrap: nowrap;" class="align-middle">S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${car.getPrecio()}" /></td>
                                            <td class="align-middle">
                                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                                <input onkeypress="return soloNumerosCantidad(event)" type="number" max="${car.getStock()}" min="1" step="1"
                                                       id="Cantidad" value="${car.getCantidad()}"
                                                       class="text-center">
                                            </td>
                                            <td class="align-middle">S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${car.getSubtotal()}" /></td>
                                            <td class="align-middle">  
                                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Delete&idp=${car.getIdProducto()}"
                                                 id="btnDelete" class="bg-danger" style="font-size: large; border: 2px solid transparent; padding: 5px; border-radius: 3px; display: flex; align-items: center; justify-content: center; color: white; text-decoration: none; width: 30px; height: 30px;">
                                                <i class="fa-solid fa-xmark fa-lg" style="color: #ffffff;"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>


                        </div>

<%--                    -------------------------------------------------------------------------------------------%>
                        

<%--                    -------------------------------------------------------------------------------------------%>

                        <script>
                            document.getElementById("limpiar").addEventListener("click", function () {
                                // Limpiar el valor del input idCliente
                                document.getElementById("idCliente").value = "";

                                // Limpiar el valor del campo nombreDisplay
                                document.getElementById("nombreDisplay").value = "";
                            });

                            document.getElementById("generico").addEventListener("click", function () {
                                // Limpiar el valor del input idCliente
                                document.getElementById("idCliente").value = "00000001";

                                // Limpiar el valor del campo nombreDisplay
                                document.getElementById("nombreDisplay").value = "CLIENTE VARIOS";
                            });
                        </script>
                        <script>
                            // Obtener el elemento del campo nombreDisplay
                            var nombreDisplay = document.getElementById("nombreDisplay");
                            var FechaHoraActual = document.getElementById("FechaHoraActual");

                            // Función para bloquear el campo de entrada
                            function bloquearCampo() {
                                // Agregar un controlador de eventos para prevenir la entrada
                                nombreDisplay.addEventListener("keydown", function (event) {
                                    // Prevenir la acción predeterminada (la entrada de texto)
                                    event.preventDefault();
                                });

                                FechaHoraActual.addEventListener("keydown", function (event){
                                    event.preventDefault();
                                })
                            }

                            // Llamar a la función bloquearCampo cuando se carga la página
                            bloquearCampo();
                        </script>

                        <div>

                            <label>Método de pago:
                                <select class="form-control" name="metodoPago" id="metodoPago">
                                    <option id="efectivo" name="metodoPago" value="1">Efectivo</option>
                                    <option id="tarjeta" name="metodoPago" value="2">Tarjeta</option>
                                </select>
                            </label>


                        </div>

                        <div class="text-center">
                            <button id="procesar-venta" class="btn btn-success" type="submit">Procesar venta</button>
                        </div>

                    </form>


                </c:if>
                <c:if test="${totalPagar > 0}">
                    <%@ page import="java.text.DecimalFormat" %>
                    <%
                        if (request.getAttribute("totalPagar") != null) {
                            double totalPagar = Double.parseDouble(request.getAttribute("totalPagar").toString());
                            
                            DecimalFormat df = new DecimalFormat("#,###,##0.00");
                            
                            String totalFormateado = df.format(totalPagar);
                            
                            double IGV = Double.parseDouble(totalFormateado) * 0.18;
                            
                            String IGVFormateado = df.format(IGV);
                            
                            String totalConIgv = String.valueOf(Double.parseDouble(IGVFormateado) + Double.parseDouble(totalFormateado));
                            
                            String totalConIgvFormateado = df.format(Double.parseDouble(totalConIgv));
                    %>

                    <div class="text-end">
                        <p>Subtotal: S/ <%=totalFormateado%></p>
                        <p>IGV (18%): S/ <%=IGVFormateado%></p>
                        <hr class="my-2">
                        <p style="font-weight:700">Total a pagar: S/ <%=totalConIgvFormateado%>
                        </p>
                        <%--                <a href="#" id="btnRealizarPago" class="btn btn-success text-center">Procesar venta</a>--%>
                    </div>

                    <% } else { %>
                    <!-- Manejar el caso cuando totalPagar no está disponible -->
                    <p>No se pudo calcular el total a pagar.</p>
                    <% } %>

                </c:if>
            </div>

            <div class="container icon-carrito">
                <c:if test="${totalPagar <= 0}">
                    <i class="fa-duotone fa-cart-xmark fa-10x d-flex justify-content-center align-items-center"></i>
                    <p class="text-center mt-5">UPS! El carrito está vacío :(</p>
                </c:if>
                <ul class="list-unstyled">
                    <li class="text-center mt-5">
                        <button id="regresar" class="btn btn-secondary"><a style="text-decoration: none;" class="text-white" href="<%=request.getContextPath()%>/caja/menu.jsp"><i class="fa-light fa-arrow-left px-2"></i>Seguir comprando</a></button>
                    </li>
                </ul>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function getCurrentDateTime() {
                var now = new Date();
                var hours = now.getHours();
                var minutes = now.getMinutes();
                var seconds = now.getSeconds();
                
                seconds = (seconds < 10) ? "0" + seconds : seconds;
                minutes = (minutes < 10) ? "0" + minutes : minutes;

                var timeString = hours + ':' + minutes + ':' + seconds;

                var day = now.getDate();
                var month = now.getMonth() + 1;
                var year = now.getFullYear();
                month = (month < 10) ? "0" + month : month;

                var dateString = day + '/' + month + '/' + year;
                var fechaString = year + '-' + month + '-' + day;

                document.getElementById("current-date").innerHTML = "Fecha actual: " + dateString;
                document.getElementById("current-time").innerHTML = "Hora actual: " + timeString;

                var FechaHoraActual = fechaString + ' ' + timeString;

                document.getElementById("FechaHoraActual").value = FechaHoraActual;
            }

            getCurrentDateTime();

            setInterval(getCurrentDateTime, 1000);
        </script>
        <script>
            function soloNumeros(evt) {
                let charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }

            function soloNumerosCantidad(evt) {
                let charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                let input = document.getElementById('Cantidad');
                if (input.value.length >= 3) {
                    evt.preventDefault();
                }
                return true;
            }
        </script>
        
        <script>
            const stockMaximo = document.getElementById("Cantidad").max;

            document.getElementById("procesar-venta").addEventListener("click", function (event) {
                var form = document.getElementById("ventaForm");
                var nombreDisplay = document.getElementById("nombreDisplay").value.trim();

                if (form.checkValidity() && nombreDisplay !== "Cliente no encontrado") {
                    // Mostrar SweetAlert de confirmación
                    // Simular impresión
                    setTimeout(function () {
                        // window.print();
                    });
                } else {
                    event.preventDefault();
                    // Mostrar SweetAlert de error
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Por favor complete todos los campos o revise que la cantidad no exceda el stock del producto.',
                    });
                }
            });
        </script>
        
        <script>
            document.addEventListener('invalid', function (e) {
                e.preventDefault();
                // Aquí puedes agregar lógica adicional, como enfocar el campo o mostrar un mensaje personalizado
                document.getElementById("nombreDisplay").focus();
                document.getElementById("efectivo").focus();
                document.getElementById("tarjeta").focus();
            }, true);
        </script>
        <script>
            const idClienteInput = document.getElementById("idCliente");
            const buscarBtn = document.getElementById("buscar");
            const limpiarBtn = document.getElementById("limpiar");
            const genericoBtn = document.getElementById("generico");

            buscarBtn.addEventListener("click", () => {
                idClienteInput.readOnly = true;
            });

            genericoBtn.addEventListener("click", () => {
                idClienteInput.readOnly = true;
            });

            limpiarBtn.addEventListener("click", () => {
                idClienteInput.readOnly = false;
            });

            function soloNumeros(event) {
                const key = event.key;
                return /\d/.test(key);
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
