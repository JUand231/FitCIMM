<%@page import="fitcimm.modelo.Membresia"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Próximas a vencer</title>
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
                <a class="nav-link " href="${pageContext.request.contextPath}/inicio">Inicio</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link " href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Membresías próximas a vencer</h3>
                <a href="${pageContext.request.contextPath}/membresias" class="btn btn-secondary">
                    Volver al listado
                </a>
            </div>
            <p class="text-muted">
                Socios cuya membresía vence dentro de los próximos 5 días.
                Contáctelos para ofrecer la renovación.
            </p>
            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%=request.getAttribute("error")%></div>
            <% } %>
            <table class="table table-bordered table-hover bg-white align-middle">
                <thead class="table-fitcimm">
                    <tr>
                        <th>Documento</th>
                        <th>Socio</th>
                        <th>Teléfono</th>
                        <th>Plan</th>
                        <th>Vence</th>
                        <th>Días restantes</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Membresia> lista = (List<Membresia>) request.getAttribute("listaMembresias");
                        if (lista != null) {
                            for (Membresia m : lista) {
                                long diasRestantes = ChronoUnit.DAYS.between(LocalDate.now(), m.getFechaFin());
                    %>
                    <tr>
                        <td><%=m.getSocio().getDocumento()%></td>
                        <td><%=m.getSocio().getNombres()%> <%=m.getSocio().getApellidos()%></td>
                        <td><%=m.getSocio().getTelefono() != null ? m.getSocio().getTelefono() : "-"%></td>
                        <td><%=m.getPlan().getNombre()%></td>
                        <td><%=m.getFechaFin()%></td>
                        <td><span class="badge bg-warning text-dark"><%=diasRestantes%> día(s)</span></td>
                    </tr>
                    <%
                        }
                        if (lista.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center text-muted">No hay membresías próximas a vencer.</td>
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