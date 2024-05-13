<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Reportes | Pollos Locos</title>
    </head>
    <body class="container-fluid p-0">
        <%--Gráfico de barras + función descargar ventas por rango de fechas--%>
        <main>
            <section>
                <div class="row m-0 d-flex align-items-center justify-content-center h-100">
                    <div class="col-md-3"></div>
                    <div class="col-md-6 text-center">
                        <svg  xmlns="http://www.w3.org/2000/svg"  width="200"  height="200"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="1"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-backhoe"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M4 17m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M13 17m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M13 19l-9 0" /><path d="M4 15l9 0" /><path d="M8 12v-5h2a3 3 0 0 1 3 3v5" /><path d="M5 15v-2a1 1 0 0 1 1 -1h7" /><path d="M21.12 9.88l-3.12 -4.88l-5 5" /><path d="M21.12 9.88a3 3 0 0 1 -2.12 5.12a3 3 0 0 1 -2.12 -.88l4.24 -4.24z" /></svg>
                        <h1>Página en Construcción</h1>
                        <p class="fs-2 text-muted">¡Estará disponible próximamente!</p>
                        <a href="${pageContext.request.contextPath}/admin/usuarios.jsp" class="btn btn-primary">Regresar</a>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </section>
        </main>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
