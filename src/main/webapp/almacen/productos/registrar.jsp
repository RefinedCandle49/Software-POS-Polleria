<%@ page import="dao.CategoriaDao" %>
<%@ page import="model.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    List<Categoria> categorias = CategoriaDao.listarCategorias();
%>
<section>
    <form action="${pageContext.request.contextPath}/controlProducto?action=registrar" method="post" enctype="multipart/form-data">
        
        <div class="container table-responsive">
            <table class="table">
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
                    <td><input type="text" name="nombre" class="form-control" required></td>
                
                <tr>
                    <th>Descripción:</th>
                    <td><textarea name="descripcion" class="form-control" required></textarea></td>
                </tr>
                
                <tr>
                    <th>Foto:</th>
                    <td><input type="text" name="foto" class="form-control" required></td>
                </tr>
                
                <tr>
                    <th>Precio:</th>
                    <td><input type="text" name="precio" class="form-control" required></td>
                </tr>
                
                <tr>
                    <th>Stock:</th>
                    <td><input type="text" name="stock" class="form-control" required></td>
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
        <input type="file" name="image" accept=".jpg, .jpeg, .png" required>
        <small>Se permiten archivos JPG y PNG de hasta 10 MB.</small>
        <input type="submit" class="btn btn-success" value="Registrar Producto">
        <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-primary">Regresar</a>
    </form>
    
<%--    <form action="${pageContext.request.contextPath}/UploadServlet" method="post" enctype="multipart/form-data">--%>
<%--        <input type="file" name="image">--%>
<%--        <input type="submit" value="Subir Imagen">--%>
<%--    </form>--%>
</section>
</body>
</html>
