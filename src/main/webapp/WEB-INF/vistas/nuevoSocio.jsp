<%@ page import="fitcimm.modelo.Socio" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Nuevo Socio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
        </nav>

        <div class="container mt-4" style="max-width: 600px;">
            <h3>Registrar nuevo socio</h3>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
            <% } %>

            <%
        Socio socio = (Socio) request.getAttribute("socio"); // null la primera vez
%>

            <form action="${pageContext.request.contextPath}/socios/nuevo" method="post">

                <div class="mb-3">
                    <label class="form-label">Documento</label>
                    <input type="text" name="documento" class="form-control" required
                           value="<%= socio != null && socio.getDocumento() != null ? socio.getDocumento() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Nombres</label>
                    <input type="text" name="nombres" class="form-control" required
                           value="<%= socio != null && socio.getNombres() != null ? socio.getNombres() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Apellidos</label>
                    <input type="text" name="apellidos" class="form-control" required
                           value="<%= socio != null && socio.getApellidos() != null ? socio.getApellidos() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="text" name="telefono" class="form-control"
                           value="<%= socio != null && socio.getTelefono() != null ? socio.getTelefono() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo</label>
                    <input type="email" name="correo" class="form-control"
                           value="<%= socio != null && socio.getCorreo() != null ? socio.getCorreo() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Fecha de nacimiento</label>
                    <input type="date" name="fechaNacimiento" class="form-control" required
                           value="<%= socio != null && socio.getFechaNacimiento() != null ? socio.getFechaNacimiento() : ""%>">
                </div>

                <button type="submit" class="btn btn-success">Guardar</button>
                <a href="${pageContext.request.contextPath}/socios" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>

    </body>
</html>