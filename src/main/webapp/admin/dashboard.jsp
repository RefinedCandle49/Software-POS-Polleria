<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h1>Ventas</h1>
<form action="<%=request.getContextPath()%>/controlDashboard?accion=buscarVentas" method="post">
    <label>
        <input required type="date" id="desde" name="desde" max="<%= LocalDate.now() %>">
    </label>
    
    <label>
        <input required type="date" id="hasta" name="hasta" max="<%= LocalDate.now() %>">
    </label>
    
    <input type="submit" value="Seleccionar">
    
</form>
</body>
</html>
