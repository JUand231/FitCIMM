<%@page import="fitcimm.modelo.EstadoMembresia"%>
<%@page import="fitcimm.modelo.Membresia"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Gestión de Membresías</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Gestión de Membresías</h3>
                <div>
                    <a href="${pageContext.request.contextPath}/membresias/proximas" class="btn btn-warning">
                        Próximas a vencer
                    </a>
                    <a href="${pageContext.request.contextPath}/membresias/nuevo" class="btn btn-primary">
                        + Nueva Membresía
                    </a>
                </div>
            </div>

            <% if (request.getAttribute("mensaje") != null) {%>
            <div class="alert alert-success"><%=request.getAttribute("mensaje")%></div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%=request.getAttribute("error")%></div>
            <% } %>

            <table class="table table-bordered table-hover bg-white align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Documento</th>
                        <th>Socio</th>
                        <th>Plan</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Valor Pagado</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Membresia> lista = (List<Membresia>) request.getAttribute("listaMembresias");

                        if (lista != null) {
                            for (Membresia m : lista) {
                    %>
                    <tr>
                        <td><%=m.getSocio().getDocumento()%></td>
                        <td><%=m.getSocio().getNombres()%> <%=m.getSocio().getApellidos()%></td>
                        <td><%=m.getPlan().getNombre()%></td>
                        <td><%=m.getFechaInicio()%></td>
                        <td><%=m.getFechaFin()%></td>
                        <td>$ <%=String.format("%,.0f", m.getValorPagado())%></td>
                        <td>
                            <%
                                EstadoMembresia estado = m.getEstadoMembresia();
                                String color = "bg-secondary";
                                if (estado == EstadoMembresia.VIGENTE) {
                                    color = "bg-success";
                                } else if (estado == EstadoMembresia.POR_VENCER) {
                                    color = "bg-warning text-dark";
                                } else if (estado == EstadoMembresia.VENCIDA) {
                                    color = "bg-danger";
                                }
                            %>
                            <span class="badge <%= color%>"><%= estado%></span>
                        </td>
                    </tr>
                    <%
                        }
                        if (lista.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No existen membresías registradas.</td>
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