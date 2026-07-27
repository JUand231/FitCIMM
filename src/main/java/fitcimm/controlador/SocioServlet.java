package fitcimm.controlador;

import fitcimm.modelo.Socio;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/socios")
public class SocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<Socio> listaSocios = socioServicio.listarSocios();
            req.setAttribute("listaSocios", listaSocios);

        } catch (SQLException e) {
            req.setAttribute("error", "Error al cargar los socios: " + e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/vistas/SocioVista.jsp").forward(req, resp);
    }
}
