<%@ page import="fitcimm.modelo.Socio, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Gestión de Socios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
            <div class="navbar-nav">
                <a class="nav-link active" href="${pageContext.request.contextPath}/socios">Socios</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/membresias">Membresías</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/planes">Planes</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/ingresos">Ingresos</a>
            </div>
        </nav>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Gestión de Socios</h3>
                <a href="${pageContext.request.contextPath}/socios/nuevo" class="btn btn-primary">+ Nuevo Socio</a>
            </div>

            <% if (request.getAttribute("mensaje") != null) {%>
            <div class="alert alert-success"><%= request.getAttribute("mensaje")%></div>
            <% } %>
            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
            <% }%>

            <form action="${pageContext.request.contextPath}/socios" method="get" class="d-flex mb-3">
                <input type="text" name="busqueda" class="form-control me-2"
                       placeholder="Buscar por documento o apellido..."
                       value="<%= request.getParameter("busqueda") != null ? request.getParameter("busqueda") : ""%>">
                <button type="submit" class="btn btn-outline-secondary">Buscar</button>
            </form>

            <table class="table table-bordered table-hover bg-white align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Documento</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Teléfono</th>
                        <th>Estado socio</th>
                        <th>Estado membresía</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Socio> listaSocios = (List<Socio>) request.getAttribute("listaSocios");
                        if (listaSocios != null) {
                            for (Socio s : listaSocios) {
                    %>
                    <tr>
                        <td><%= s.getDocumento()%></td>
                        <td><%= s.getNombres()%></td>
                        <td><%= s.getApellidos()%></td>
                        <td><%= s.getTelefono() != null ? s.getTelefono() : "-"%></td>
                        <td>
                            <span class="badge <%= s.isActivo() ? "bg-success" : "bg-secondary"%>">
                                <%= s.isActivo() ? "Activo" : "Inactivo"%>
                            </span>
                        </td>
                        <td>
                            <%
                                String estadoMem = s.getEstadoMembresia(); // null si nunca ha tenido membresía
                                String badgeClass = "bg-secondary";
                                String texto = "Sin membresía";
                                if (estadoMem != null) {
                                    texto = estadoMem;
                                    if (estadoMem.equals("VIGENTE")) {
                                        badgeClass = "bg-success";
                                    } else if (estadoMem.equals("POR VENCER")) {
                                        badgeClass = "bg-warning text-dark";
                                    } else if (estadoMem.equals("VENCIDA")) {
                                        badgeClass = "bg-danger";
                                    }
                                }
                            %>
                            <span class="badge <%= badgeClass%>"><%= texto%></span>
                        </td>
                        <td class="text-center">
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light border" type="button"
                                        data-bs-toggle="dropdown" aria-expanded="false">⋮</button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item"
                                           href="${pageContext.request.contextPath}/socios/detalle?id=<%= s.getIdSocio()%>">Ver detalle</a></li>
                                    <li><a class="dropdown-item"
                                           href="${pageContext.request.contextPath}/socios/editar?id=<%= s.getIdSocio()%>">Editar</a></li>
                                    <li>
                                        <form action="${pageContext.request.contextPath}/socios/inactivar" method="post"
                                              onsubmit="return confirm('¿Inactivar este socio?');">
                                            <input type="hidden" name="id" value="<%= s.getIdSocio()%>">
                                            <button type="submit" class="dropdown-item text-danger"
                                                    <%= !s.isActivo() ? "disabled" : ""%>>Inactivar</button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                        if (listaSocios.isEmpty()) {
                    %>
                    <tr><td colspan="7" class="text-center text-muted">No hay socios registrados.</td></tr>
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