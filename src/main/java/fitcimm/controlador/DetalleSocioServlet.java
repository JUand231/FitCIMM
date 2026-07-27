package fitcimm.controlador;

import fitcimm.modelo.Membresia;
import fitcimm.modelo.Socio;
import fitcimm.servicio.MembresiaServicio;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/socios/detalle")
public class DetalleSocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();
    private MembresiaServicio membresiaServicio = new MembresiaServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));

            Socio socio = socioServicio.consultarDetalle(idSocio);
            List<Membresia> historial = membresiaServicio.listarPorSocio(idSocio);

            req.setAttribute("socio", socio);
            req.setAttribute("historial", historial);
            req.getRequestDispatcher("/WEB-INF/vistas/detalleSocio.jsp").forward(req, resp);

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/socios");
        }
    }
}
