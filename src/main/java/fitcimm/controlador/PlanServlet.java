package fitcimm.controlador;

import fitcimm.modelo.Plan;
import fitcimm.servicio.PlanServicio;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/planes")
public class PlanServlet extends HttpServlet {

    private PlanServicio planServicio = new PlanServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            List<Plan> listaPlanes = planServicio.listarPlanes();
            req.setAttribute("listaPlanes", listaPlanes);

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        req.getRequestDispatcher("/WEB-INF/vistas/PlanVista.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getParameter("accion");

        // Cambiar estado del plan
        if ("cambiarEstado".equals(accion)) {

            try {

                int id = Integer.parseInt(req.getParameter("id"));
                boolean activo = Boolean.parseBoolean(req.getParameter("activo"));

                planServicio.cambiarEstado(id, activo);

            } catch (SQLException e) {

                req.setAttribute("error", e.getMessage());

            }

            resp.sendRedirect(req.getContextPath() + "/planes");
            return;
        }

        // Registrar plan
        try {

            Plan plan = new Plan();

            plan.setNombre(req.getParameter("nombre"));
            plan.setDuracionDias(Integer.parseInt(req.getParameter("duracionDias")));
            plan.setValor(Double.parseDouble(req.getParameter("valor")));

            if (planServicio.registrarPlan(plan)) {

                resp.sendRedirect(req.getContextPath() + "/planes");
                return;

            } else {

                req.setAttribute("error", "No fue posible registrar el plan.");
            }

        } catch (SQLException e) {

            req.setAttribute("error", e.getMessage());

        }

        doGet(req, resp);
    }
}
