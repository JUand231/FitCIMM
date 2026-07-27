<%@ page import="fitcimm.modelo.Socio" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Editar Socio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">FITCIMM</a>
        </nav>

        <div class="container mt-4" style="max-width: 600px;">
            <h3>Editar socio</h3>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
            <% } %>

            <%
                Socio socio = (Socio) request.getAttribute("socio");
            %>

            <form action="${pageContext.request.contextPath}/socios/editar" method="post">
                <input type="hidden" name="idSocio" value="<%= socio.getIdSocio()%>">

                <div class="mb-3">
                    <label class="form-label">Documento</label>
                    <input type="text" class="form-control" value="<%= socio.getDocumento()%>" disabled>
                    <input type="hidden" name="documento" value="<%= socio.getDocumento()%>">
                    <small class="text-muted">El documento no se puede modificar.</small>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nombres</label>
                    <input type="text" name="nombres" class="form-control" required
                           value="<%= socio.getNombres()%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Apellidos</label>
                    <input type="text" name="apellidos" class="form-control" required
                           value="<%= socio.getApellidos()%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="text" name="telefono" class="form-control"
                           value="<%= socio.getTelefono() != null ? socio.getTelefono() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo</label>
                    <input type="email" name="correo" class="form-control"
                           value="<%= socio.getCorreo() != null ? socio.getCorreo() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Fecha de nacimiento</label>
                    <input type="date" name="fechaNacimiento" class="form-control" required
                           value="<%= socio.getFechaNacimiento()%>">
                </div>

                <button type="submit" class="btn btn-success">Guardar cambios</button>
                <a href="${pageContext.request.contextPath}/socios" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>

    </body>
</html>