<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Registrar Usuario | Pollos Locos</title>
        <!-- Bootstrap v5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/registrar.css">
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession(false);
            
            if (sesion == null || sesion.getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
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

                <form action="${pageContext.request.contextPath}/controlUsuario?action=registrar" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol:</label>
                        <select class="form-select" id="rol" name="rol">
                            <option value="Administrador">Administrador</option>
                            <option value="Cajero">Cajero</option>
                            <option value="Almacenero">Almacenero</option>
                        </select>
                    </div>

                    <input type="hidden" name="estado" value="1">

                    <div class="text-center">
                        <button type="submit" class="btn btn-dark" >Registrar</button>
                    </div>
                </form>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
