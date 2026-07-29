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

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/socios">
                            <i class="bi bi-people-fill"></i>
                            Socios
                        </a>

                        <a class="nav-link active"
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
                <h3>Membresías próximas a vencer</h3>
                <a href="${pageContext.request.contextPath}/membresias" class="btn btn-secondary">
                    Volver al listado
                </a>
            </div>
            <p class="text-muted">
                Socios cuya membresía vence dentro de los próximos 5 días.
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