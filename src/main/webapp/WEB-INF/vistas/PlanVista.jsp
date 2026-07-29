<%@page import="java.util.List"%>
<%@page import="fitcimm.modelo.Plan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>FitCIMM - Gestión de Planes</title>

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

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/membresias">
                            <i class="bi bi-card-checklist"></i>
                            Membresías
                        </a>

                        <a class="nav-link active"
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