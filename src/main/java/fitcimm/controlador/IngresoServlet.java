package fitcimm.controlador;

import fitcimm.modelo.ConsultaIngreso;
import fitcimm.modelo.Socio;
import fitcimm.servicio.IngresoServicio;
import fitcimm.servicio.MembresiaServicio;
import fitcimm.servicio.SocioServicio;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ingresos")
public class IngresoServlet extends HttpServlet {

    private IngresoServicio ingresoServicio = new IngresoServicio();
    private SocioServicio socioServicio = new SocioServicio();
    private MembresiaServicio membresiaServicio = new MembresiaServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String fecha = req.getParameter("fecha");

            List<ConsultaIngreso> listaIngresos = new ArrayList<>();

            if (fecha != null && !fecha.trim().isEmpty()) {

                LocalDate fechaConsulta = LocalDate.parse(fecha);

                listaIngresos = ingresoServicio.consultarPorFecha(fechaConsulta);

            } else {

                listaIngresos = ingresoServicio.listarIngresos();

            }

            req.setAttribute("listaIngresos", listaIngresos);

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/IngresoVista.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String documento = req.getParameter("documento");

            Socio socio = socioServicio.ingresoPorDocumento(documento);

            if (socio == null) {

                req.setAttribute("error", "El socio no existe.");

            } else if (!socio.isActivo()) {

                req.setAttribute("error", "El socio está inactivo.");
            } else if (!membresiaServicio.tieneMembresiaVigente(socio.getIdSocio())) {

                req.setAttribute("error",
                        "El socio no tiene una membresía vigente.");

            } else if (ingresoServicio.ingresoRegistrado(socio.getIdSocio())) {

                req.setAttribute("error", "El ingreso ya fue registrado el día de hoy.");

            } else {

                ingresoServicio.registrarIngreso(socio.getIdSocio());

                req.setAttribute("mensaje",
                        "Ingreso registrado correctamente para "
                        + socio.getNombres() + " " + socio.getApellidos());

            }

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/InicioVista.jsp")
                .forward(req, resp);
    }
}
