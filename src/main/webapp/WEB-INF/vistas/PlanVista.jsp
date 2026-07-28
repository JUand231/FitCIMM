<%@page import="java.util.List"%>
<%@page import="fitcimm.modelo.Plan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Gestión de Planes</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            :root {
                --fitcimm-blue: #0d3b66;
                --fitcimm-blue-dark: #092947;
            }

            .navbar-fitcimm {
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

            .table-fitcimm {
                background-color: var(--fitcimm-blue) !important;
                color: #fff;
            }
        </style>

    </head>

    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark navbar-fitcimm px-3">

            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
                FITCIMM
            </a>

            <div class="navbar-nav">

                <a class="nav-link" href="${pageContext.request.contextPath}/inicio">
                    Inicio
                </a>

                <a class="nav-link" href="${pageContext.request.contextPath}/socios">
                    Socios
                </a>

                <a class="nav-link" href="${pageContext.request.contextPath}/membresias">
                    Membresías
                </a>

                <a class="nav-link active" href="${pageContext.request.contextPath}/planes">
                    Planes
                </a>

                <a class="nav-link" href="${pageContext.request.contextPath}/ingresos">
                    Ingresos
                </a>

            </div>

        </nav>

        <div class="container mt-5">

            <div class="d-flex justify-content-between align-items-center mb-3">

                <h3>Gestión de Planes</h3>

            </div>

            <% if(request.getAttribute("error") != null){ %>

            <div class="alert alert-danger">
                <%=request.getAttribute("error")%>
            </div>

            <% } %>

            <div class="card shadow mb-4">

                <div class="card-header table-fitcimm">

                    <h5 class="mb-0">
                        Registrar Plan
                    </h5>

                </div>

                <div class="card-body">

                    <form action="${pageContext.request.contextPath}/planes" method="post">

                        <div class="row">

                            <div class="col-md-4 mb-3">

                                <label class="form-label">
                                    Nombre
                                </label>

                                <input
                                    type="text"
                                    name="nombre"
                                    class="form-control"
                                    required>

                            </div>

                            <div class="col-md-4 mb-3">

                                <label class="form-label">
                                    Duración (días)
                                </label>

                                <input
                                    type="number"
                                    name="duracionDias"
                                    class="form-control"
                                    required>

                            </div>

                            <div class="col-md-4 mb-3">

                                <label class="form-label">
                                    Valor
                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    name="valor"
                                    class="form-control"
                                    required>

                            </div>

                        </div>

                        <button class="btn btn-fitcimm">
                            Registrar Plan
                        </button>

                    </form>

                </div>

            </div>

            <table class="table table-bordered table-hover bg-white align-middle">

                <thead class="table-fitcimm">

                    <tr>

                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Duración</th>
                        <th>Valor</th>
                        <th>Estado</th>

                    </tr>

                </thead>

                <tbody>

                    <%

                        List<Plan> lista = (List<Plan>) request.getAttribute("listaPlanes");

                        if (lista != null) {

                            for (Plan p : lista) {

                    %>

                    <tr>

                        <td><%=p.getIdPlan()%></td>

                        <td><%=p.getNombre()%></td>

                        <td><%=p.getDuracionDias()%> días</td>

                        <td>$ <%=String.format("%,.0f", p.getValor())%></td>

                        <td>

                            <% if (p.isActivo()) { %>

                            <span class="badge bg-success">
                                Activo
                            </span>

                            <% } else { %>

                            <span class="badge bg-danger">
                                Inactivo
                            </span>

                            <% } %>

                        </td>

                    </tr>

                    <%

                            }

                            if (lista.isEmpty()) {

                    %>

                    <tr>

                        <td colspan="5" class="text-center text-muted">
                            No existen planes registrados.
                        </td>

                    </tr>

                    <%

                            }

                        }

                    %>

                </tbody>

            </table>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>

</html>