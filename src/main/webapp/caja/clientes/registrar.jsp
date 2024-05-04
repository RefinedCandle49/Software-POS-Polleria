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

        <div>
            <div>
                <h1>Registro de Usuario</h1>

                <form action="${pageContext.request.contextPath}/controlCliente?action=registrar" method="post">

                    <label for="idCliente" >DNI/RUC:</label>
                    <input type="text" id="idCliente" name="idCliente" required>

                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                    
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" required>
                    
                    <label for="email">Email:</label>
                    <input type="text" id="email" name="email" required>

                    <button type="submit" >Registrar</button>

                </form>
            </div>
        </div>


    </body>
</html>
