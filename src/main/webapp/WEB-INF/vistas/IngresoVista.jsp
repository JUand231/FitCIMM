<%@ page import="java.util.List"%>
<%@ page import="fitcimm.modelo.ConsultaIngreso" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Ingresos</title>
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
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/inicio">Inicio</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>
        <div class="container mt-4">
            <h3 class="mb-3">Consulta de Ingresos</h3>
            <form action="${pageContext.request.contextPath}/ingresos" method="get"
                  class="row g-2 mb-4">
                <div class="col-md-4">
                    <input type="date"
                           name="fecha"
                           class="form-control"
                           value="<%= request.getParameter("fecha") != null ? request.getParameter("fecha") : ""%>">
                </div>
                <div class="col-md-2">
                    <button class="btn btn-fitcimm w-100">
                        Buscar
                    </button>
                </div>
            </form>
            <table class="table table-bordered table-hover bg-white">
                <thead class="table-fitcimm">
                    <tr>
                        <th>Documento</th>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ConsultaIngreso> lista
                                = (List<ConsultaIngreso>) request.getAttribute("listaIngresos");
                        if (lista != null) {
                            for (ConsultaIngreso i : lista) {
                    %>
                    <tr>
                        <td><%= i.getDocumento()%></td>
                        <td><%= i.getNombres()%> <%= i.getApellidos()%></td>
                        <td><%= i.getFechaIngreso()%></td>
                        <td><%= i.getHoraIngreso()%></td>
                    </tr>
                    <%
                        }
                        if (lista.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">
                            No hay ingresos registrados para esa fecha.
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