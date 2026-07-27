package fitcimm.controlador;

import fitcimm.modelo.Membresia;
import fitcimm.servicio.MembresiaServicio;
import fitcimm.servicio.PlanServicio;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/membresias/*")
public class MembresiaServlet extends HttpServlet {

    private MembresiaServicio membresiaServicio = new MembresiaServicio();
    private SocioServicio socioServicio = new SocioServicio();
    private PlanServicio planServicio = new PlanServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getPathInfo();

        if (accion == null || accion.equals("/") || accion.isEmpty()) {

            listar(req, resp);

        } else if (accion.equals("/nuevo")) {

            mostrarFormularioNueva(req, resp);

        } else if (accion.equals("/proximas")) {

            listarProximas(req, resp);

        } else {

            resp.sendError(HttpServletResponse.SC_NOT_FOUND);

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getPathInfo();

        if (accion != null && accion.equals("/nuevo")) {

            registrar(req, resp);

        } else {

            resp.sendError(HttpServletResponse.SC_NOT_FOUND);

        }
    }

    // LISTAR MEMBRESÍAS
    private void listar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            List<Membresia> lista = membresiaServicio.listarMembresias();

            req.setAttribute("listaMembresias", lista);

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/MembresiaVista.jsp")
                .forward(req, resp);

    }

    // MOSTRAR FORMULARIO
    private void mostrarFormularioNueva(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            req.setAttribute("listaSocios",
                    socioServicio.listarSocios());

            req.setAttribute("listaPlanes",
                    planServicio.listarPlanes());

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/NuevaMembresia.jsp")
                .forward(req, resp);

    }

    // REGISTRAR
    private void registrar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            Membresia membresia = new Membresia();

            membresia.setIdSocio(
                    Integer.parseInt(req.getParameter("idSocio")));

            membresia.setIdPlan(
                    Integer.parseInt(req.getParameter("idPlan")));

            boolean registrado
                    = membresiaServicio.registrarMembresia(membresia);

            if (registrado) {

                resp.sendRedirect(req.getContextPath() + "/membresias");

            } else {

                req.setAttribute("error",
                        "No fue posible registrar la membresía.");

                mostrarFormularioNueva(req, resp);

            }

        } catch (Exception e) {

            req.setAttribute("error", e.getMessage());

            mostrarFormularioNueva(req, resp);

        }

    }

    // PRÓXIMAS A VENCER
    private void listarProximas(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            List<Membresia> lista
                    = membresiaServicio.listarProximasAVencer();

            req.setAttribute("listaMembresias", lista);

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/MembresiaProximas.jsp")
                .forward(req, resp);

    }

}
