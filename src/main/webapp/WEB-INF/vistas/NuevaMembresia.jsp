<%@ page import="fitcimm.modelo.Socio,fitcimm.modelo.Plan,java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Nueva Membresía</title>

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

            <div class="card shadow">

                <div class="card-header bg-fitcimm text-white">
                    <h4>Nueva Membresía</h4>
                </div>

                <div class="card-body">

                    <% if (request.getAttribute("error") != null) {%>

                    <div class="alert alert-danger">
                        <%=request.getAttribute("error")%>
                    </div>

                    <% } %>

                    <form action="${pageContext.request.contextPath}/membresias/nuevo"
                          method="post">

                        <div class="mb-3">

                            <label class="form-label">
                                Socio
                            </label>

                            <select class="form-select"
                                    name="idSocio"
                                    required>

                                <option value="">
                                    Seleccione...
                                </option>

                                <%

                                    List<Socio> socios
                                            = (List<Socio>) request.getAttribute("listaSocios");

                                    if (socios != null) {

                                        for (Socio s : socios) {

                                %>

                                <option value="<%=s.getIdSocio()%>">

                                    <%=s.getDocumento()%> -
                                    <%=s.getNombres()%>
                                    <%=s.getApellidos()%>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">
                                Plan
                            </label>

                            <select class="form-select"
                                    name="idPlan"
                                    required>

                                <option value="">
                                    Seleccione...
                                </option>

                                <%                            List<Plan> planes
                                            = (List<Plan>) request.getAttribute("listaPlanes");

                                    if (planes != null) {

                                        for (Plan p : planes) {

                                %>

                                <option value="<%=p.getIdPlan()%>">

                                    <%=p.getNombre()%>
                                    -
                                    $<%=String.format("%,.0f", p.getValor())%>

                                </option>

                                <%

                                        }

                                    }

                                %>

                            </select>

                        </div>

                        <button class="btn btn-fitcimm">
                            Registrar Membresía
                        </button>

                        <a class="btn btn-secondary"
                           href="${pageContext.request.contextPath}/membresias">
                            Cancelar
                        </a>

                    </form>

                </div>

            </div>

        </div>

    </body>
</html>