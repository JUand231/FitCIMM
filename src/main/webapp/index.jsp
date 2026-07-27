<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.sendRedirect(request.getContextPath() + "/socios");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FITCIMM</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
    </head>

    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-success shadow">
            <div class="container-fluid">

                <a class="navbar-brand fw-bold" href="#">
                    <i class="bi bi-activity"></i>
                    FITCIMM
                </a>

                <div class="navbar-nav ms-auto">

                    <a class="nav-link active" href="#">Socios</a>

                    <a class="nav-link" href="#">Membresías</a>

                    <a class="nav-link" href="#">Planes</a>

                    <a class="nav-link" href="#">Ingresos</a>

                    <a class="nav-link text-warning" href="#">
                        Salir
                    </a>

                </div>

            </div>
        </nav>

        <div class="container mt-5">

            <div class="text-center">

                <h2>Bienvenido a FITCIMM</h2>

                <p class="text-secondary">
                    Seleccione una opción del menú para comenzar.
                </p>

            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>