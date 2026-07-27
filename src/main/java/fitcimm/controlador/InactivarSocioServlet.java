package fitcimm.controlador;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/socios/inactivar")
public class InactivarSocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));
            socioServicio.inactivarSocio(idSocio);

        } catch (Exception e) {
            // si falla, simplemente no inactiva; podrías loguear el error si quieres
        }

        resp.sendRedirect(req.getContextPath() + "/socios");
    }
}
