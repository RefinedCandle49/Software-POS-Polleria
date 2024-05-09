<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, model.Cliente, dao.ClienteDao,java.util.*" %>
<html>
    <head>
        <title>Clientes | Pollos Locos</title>
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

        <main>
            <article>
                <section>
                    <h1>Panel de Clientes</h1>

                    <a href="${pageContext.request.contextPath}/caja/clientes/registrar.jsp">Registrar Cliente</a>
                    
                    <c:if test="${ empty list}">
                        <span>¡Hola! Parece que esta tabla está vacía en este momento. ¡Ingresa datos para llenarla!</span>
                    </c:if>
                        
                        <c:if test="${not empty param.registroExitoso}">
                            <div id="registroExitoso" class="alert alert-success d-flex align-items-center justify-content-between">
                                ${param.registroExitoso}
                                <button type="button" class="button-mensaje text-success" onclick="cerrarMensaje()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                            </div> 
                        </c:if>
                    
                    <c:if test="${not empty list}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombres</th>
                                    <th>Apellidos</th>
                                    <th>Correo Electrónico</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="cli">
                                    <tr>
                                        <td>${cli.getIdCliente()}</td>
                                        <td>${cli.getNombre()}</td>
                                        <td>${cli.getApellido()}</td>
                                        <td>${cli.getEmail()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </section>
            </article>
        </main>

        <script>
            function cerrarMensaje() {
                let registroExitoso = document.getElementById("registroExitoso");
                registroExitoso.style.display = "none";
                window.location.href = "${pageContext.request.contextPath}/caja/clientes/cartera.jsp"
            }
        </script>
    </body>
</html>
