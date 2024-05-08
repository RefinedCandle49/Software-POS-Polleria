<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, model.Cliente, dao.ClienteDao, java.util.*" %>
<html>
    <head>
        <title>Registrar Cliente | Pollos Locos</title>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/registrar-cliente.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%--En esta sección se hará el registro de clientes que paguen tanto con factura como con boleta--%>
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
            
        List<Cliente> cliente = ClienteDao.listarClientes();
        request.setAttribute("list", cliente);
        %>

        <header>
            Bienvenido, <%= nombreRol %>
            <a href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a>
        </header>

        <div class="centered-form">
            <div class="shadowed-box">
                <h1>Registro de Usuario</h1>

                <c:if test="${not empty mensajeError}">
                    <div>
                        <c:out value="${mensajeError}" />
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/controlCliente?action=registrar" method="post">

                    <div class="mb-3">
                        <label for="idCliente" class="form-label">DNI/RUC:</label>
                        <input type="text" id="idCliente" name="idCliente" class="form-control" maxlength="11" onkeypress="return soloNumeros(event)" required>
                    </div>

                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" maxlength="50" onkeypress="return soloLetras(event)" required>
                    </div>

                    <div class="mb-3">
                        <label for="apellido" class="form-label">Apellido:</label>
                        <input type="text" id="apellido" name="apellido" class="form-control" maxlength="50" onkeypress="return soloLetras(event)" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="text" id="email" name="email" class="form-control" maxlength="80" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-dark" >Registrar</button>
                        <a href="${pageContext.request.contextPath}/caja/menu.jsp" class="btn btn-primary">Regresar</a>
                    </div> 
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function soloNumeros(evt){
                let charCode = (evt.which) ? evt.which : event.keyCode;
                if(charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
            
            function soloLetras(evt){
                let regex = /^[a-zA-Z\s]*$/;
                let key = String.fromCharCode(!evt.charCode ? evt.which : evt.charCode);
                if(!regex.test(key)){
                    evt.preventDefault();
                    return false;
                }
            }
        </script>
    </body>
</html>
