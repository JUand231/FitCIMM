<%@ page import="fitcimm.modelo.Socio, fitcimm.modelo.Membresia, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Detalle Socio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --fitcimm-blue: #0d3b66;
                --fitcimm-blue-dark: #092947;
            }
            .navbar-fitcimm {
                background-color: var(--fitcimm-blue) !important;
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>

        <div class="container mt-4">
            <%
                Socio socio = (Socio) request.getAttribute("socio");
                List<Membresia> historial = (List<Membresia>) request.getAttribute("historial");
            %>

            <h3><%= socio.getNombres()%> <%= socio.getApellidos()%></h3>
            <p><strong>Documento:</strong> <%= socio.getDocumento()%></p>
            <p><strong>Teléfono:</strong> <%= socio.getTelefono() != null ? socio.getTelefono() : "-"%></p>
            <p><strong>Correo:</strong> <%= socio.getCorreo() != null ? socio.getCorreo() : "-"%></p>
            <p><strong>Fecha de nacimiento:</strong> <%= socio.getFechaNacimiento()%></p>

            <h5 class="mt-4">Historial de membresías</h5>
            <table class="table table-bordered bg-white">
                <thead class="table-fitcimm">
                    <tr>
                        <th>Plan</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Valor pagado</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (historial != null) {
                            for (Membresia m : historial) {
                    %>
                    <tr>
                        <td><%= m.getPlan().getNombre()%></td>
                        <td><%= m.getFechaInicio()%></td>
                        <td><%= m.getFechaFin()%></td>
                        <td><%= m.getValorPagado()%></td>
                    </tr>
                    <%
                        }
                        if (historial.isEmpty()) {
                    %>
                    <tr><td colspan="4" class="text-center text-muted">Este socio aún no tiene membresías.</td></tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>

            <a href="${pageContext.request.contextPath}/socios" class="btn btn-secondary">Volver</a>
        </div>

    </body>
</html>