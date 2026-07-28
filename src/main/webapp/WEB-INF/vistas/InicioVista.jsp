<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FITCIMM - Recepción</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            :root {
                --fitcimm-blue: #0d3b66;
                --fitcimm-blue-dark: #092947;
            }
            .navbar-fitcimm {
                background-color: var(--fitcimm-blue) !important;
            }
            .bg-fitcimm {
                background-color: var(--fitcimm-blue) !important;
            }
            .btn-fitcimm {
                background-color: var(--fitcimm-blue);
                border-color: var(--fitcimm-blue);
                color: #fff;
            }
            .btn-fitcimm:hover {
                background-color: var(--fitcimm-blue-dark);
                border-color: var(--fitcimm-blue-dark);
                color: #fff;
            }
        </style>
    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-fitcimm px-3">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
            <div class="navbar-nav">
                <a class="nav-link active" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link " href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow">
                        <div class="card-header bg-fitcimm text-white text-center">
                            <h3 class="mb-0">
                                <i class="bi bi-door-open-fill"></i>
                                Recepción
                            </h3>
                        </div>
                        <div class="card-body">
                            <p class="text-center text-secondary">
                                Digite el número de documento del socio para registrar su ingreso al gimnasio.
                            </p>
                            <form action="${pageContext.request.contextPath}/ingresos" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">
                                        Número de documento
                                    </label>
                                    <input
                                        type="text"
                                        name="documento"
                                        class="form-control form-control-lg"
                                        placeholder="Ej: 1001001001"
                                        required>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-fitcimm btn-lg">
                                        <i class="bi bi-check-circle"></i>
                                        Registrar ingreso
                                    </button>
                                </div>
                            </form>
                            <% if (request.getAttribute("mensaje") != null) {%>
                            <div class="alert alert-success mt-4">
                                <%= request.getAttribute("mensaje")%>
                            </div>
                            <% } %>
                            <% if (request.getAttribute("error") != null) {%>
                            <div class="alert alert-danger mt-4">
                                <%= request.getAttribute("error")%>
                            </div>
                            <% }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>