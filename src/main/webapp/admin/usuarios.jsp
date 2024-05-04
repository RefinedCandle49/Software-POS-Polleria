<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<html>
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <title>Usuarios | Pollos Locos</title>
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
            
        List<Usuario> usuario = UsuarioDao.listarUsuarios();
        request.setAttribute("list", usuario);
        %>

        <header>
            Bienvenido, <%= nombreRol %>
            <a href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a>
        </header>

        <main>
            <article>
                <section>
                    <h1>Panel de Usuarios</h1>

                    <a href="${pageContext.request.contextPath}/admin/registrar.jsp">Registrar Usuario</a>

                    <c:if test="${not empty list}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Correo Electrónico</th>
                                    <th>Contraseña</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="user">
                                    <tr>
                                        <td>${user.getIdUsuario()}</td>
                                        <td>${user.getEmail()}</td>
                                        <td>${user.getPassword()}</td>
                                        <td>${user.getRol()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.getEstado() == 0}">Inactivo</c:when>
                                                <c:when test="${user.getEstado() == 1}">Activo</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </c:if>
                </section>
            </article>
        </main>
    </body>
</html>
