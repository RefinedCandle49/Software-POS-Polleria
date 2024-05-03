<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, dao.UsuarioDao, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Usuario</title>
    <!-- Bootstrap v5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/registrar.css">
</head>
<body>
<div class="centered-form">
    <div class="shadowed-box">
        <h1>Registro de Usuario</h1>

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
            <div class="mb-3">
                <label for="estado" class="form-label">Estado:</label>
                <input type="text" class="form-control" id="estado" name="estado">
            </div>
	    <div class="text-center">
            <button type="submit" class="btn btn-dark" >Registrar</button>
	    </div>
        </form>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
