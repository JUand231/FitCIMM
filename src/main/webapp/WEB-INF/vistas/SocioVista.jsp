<%@ page import="fitcimm.modelo.Socio, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Gestión de Socios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">

        <style>
            :root {
                --fitcimm-blue: #0d3b66;
                --fitcimm-blue-dark: #092947;
                --fitcimm-gold: #f4b400;
            }

            body{
                background:#f5f7fb;
            }

            .navbar-fitcimm{
                background: linear-gradient(135deg,#0d3b66,#155a96);
                margin:15px;
                border-radius:18px;
                padding:12px 22px;
                box-shadow:0 10px 25px rgba(0,0,0,.18);
            }

            .logo-fitcimm{
                width:48px;
                height:48px;
                border-radius:12px;
                background:white;
                color:#0d3b66;
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:24px;
                margin-right:12px;
            }

            .brand-title{
                line-height:1;
            }

            .brand-title span{
                display:block;
                font-size:.78rem;
                color:#dbe9ff;
                font-weight:400;
            }

            .navbar-nav .nav-link{
                color:white !important;
                font-weight:500;
                margin-left:8px;
                padding:10px 18px !important;
                border-radius:12px;
                transition:.3s;
            }

            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link.active{
                background:rgba(255,255,255,.15);
                transform:translateY(-2px);
            }

            .bg-fitcimm{
                background:linear-gradient(135deg,#0d3b66,#155a96);
            }

            .btn-fitcimm{
                background:#0d3b66;
                border:none;
                color:#fff;
            }

            .btn-fitcimm:hover{
                background:#092947;
            }
        </style>
    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-fitcimm">

            <div class="container-fluid">

                <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/inicio">

                    <div class="logo-fitcimm">
                        <i class="bi bi-heart-pulse-fill"></i>
                    </div>

                    <div class="brand-title fw-bold fs-4">
                        FITCIMM
                        <span>Sistema de Gestión</span>
                    </div>

                </a>

                <button class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#menuFitcimm">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="menuFitcimm">

                    <div class="navbar-nav">

                        <a class="nav-link "
                           href="${pageContext.request.contextPath}/inicio">
                            <i class="bi bi-house-door-fill"></i>
                            Inicio
                        </a>

                        <a class="nav-link active"
                           href="${pageContext.request.contextPath}/socios">
                            <i class="bi bi-people-fill"></i>
                            Socios
                        </a>

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/membresias">
                            <i class="bi bi-card-checklist"></i>
                            Membresías
                        </a>

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/planes">
                            <i class="bi bi-clipboard2-pulse-fill"></i>
                            Planes
                        </a>

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/ingresos">
                            <i class="bi bi-door-open-fill"></i>
                            Ingresos
                        </a>

                    </div>

                </div>

            </div>

        </nav>

        <div class="container mt-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Gestión de Socios</h3>
                <a href="${pageContext.request.contextPath}/socios/nuevo" class="btn btn-fitcimm">+ Nuevo Socio</a>
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
                <thead class="table-fitcimm">
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