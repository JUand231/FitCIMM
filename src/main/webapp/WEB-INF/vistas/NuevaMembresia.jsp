<%@ page import="fitcimm.modelo.Socio,fitcimm.modelo.Plan,java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Membresía</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --fitcimm-blue: #0d3b66;
            --fitcimm-blue-dark: #092947;
        }
        .navbar-fitcimm {
            background-color: var(--fitcimm-blue) !important;
        }
        .bg-fitcimm {
            background-color: var(--fitcimm-blue) !important;
        }
        .btn-fitcimm {
            background-color: var(--fitcimm-blue);
            border-color: var(--fitcimm-blue);
            color: #fff;
        }
        .btn-fitcimm:hover {
            background-color: var(--fitcimm-blue-dark);
            border-color: var(--fitcimm-blue-dark);
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

    <div class="card shadow">

        <div class="card-header bg-fitcimm text-white">
            <h4>Nueva Membresía</h4>
        </div>

        <div class="card-body">

            <% if(request.getAttribute("error") != null){ %>

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

                            List<Socio> socios =
                                    (List<Socio>)request.getAttribute("listaSocios");

                            if(socios!=null){

                                for(Socio s : socios){

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

                        <%

                            List<Plan> planes =
                                    (List<Plan>)request.getAttribute("listaPlanes");

                            if(planes!=null){

                                for(Plan p : planes){

                        %>

                        <option value="<%=p.getIdPlan()%>">

                            <%=p.getNombre()%>
                            -
                            $<%=String.format("%,.0f",p.getValor())%>

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