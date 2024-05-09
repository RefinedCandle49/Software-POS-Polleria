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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
            <div class="container mt-5">
            <ul class="bg-dark nav justify-content-end d-flex container"> 
                <li class=" nav-item">
                    <span class="text-white nav-link">Bienvenido, <%= nombreRol %></span>
                </li>
                <li class="nav-item">
                    <a class="text-white nav-link" href="${pageContext.request.contextPath}/logout.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </div>
        </header>

        <main>
            <article>
                <section>
                    <h1 class="text-center mt-5">Panel de Clientes</h1>

                    <button style="margin-left: 92rem" class="btn btn-success"><a style="text-decoration: none;" class="text-white" href="${pageContext.request.contextPath}/caja/clientes/registrar.jsp">Registrar Cliente</a></button>
                    
                    <c:if test="${ empty list}">
                        <span>¡Hola! Parece que esta tabla está vacía en este momento. ¡Ingresa datos para llenarla!</span>
                    </c:if>
                    
                    <c:if test="${not empty list}">
                        <div clas="table-responsive-md">
                            <table class="mt-2 table table-bordered container">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-center">ID</th>
                                    <th class="text-center">Nombres</th>
                                    <th class="text-center">Apellidos</th>
                                    <th class="text-center">Correo Electrónico</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="cli">
                                    <tr>
                                        <td class="text-center">${cli.getIdCliente()}</td>
                                        <td class="text-center">${cli.getNombre()}</td>
                                        <td class="text-center">${cli.getApellido()}</td>
                                        <td class="text-center">${cli.getEmail()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        </div>

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
