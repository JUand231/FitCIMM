package fitcimm.controlador;

import fitcimm.modelo.Socio;
import fitcimm.servicio.NegocioException;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/socios/nuevo")
public class NuevoSocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();

    // Muestra el formulario vacío
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/vistas/nuevoSocio.jsp").forward(req, resp);
    }

    // Procesa el formulario
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Socio socio = new Socio();
        socio.setDocumento(req.getParameter("documento"));
        socio.setNombres(req.getParameter("nombres"));
        socio.setApellidos(req.getParameter("apellidos"));
        socio.setTelefono(req.getParameter("telefono"));
        socio.setCorreo(req.getParameter("correo"));

        String fechaTexto = req.getParameter("fechaNacimiento");
        if (fechaTexto != null && !fechaTexto.isBlank()) {
            socio.setFechaNacimiento(LocalDate.parse(fechaTexto));
        }

        try {
            socioServicio.registrarSocio(socio);
            resp.sendRedirect(req.getContextPath() + "/socios");

        } catch (NegocioException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio); // para no perder lo digitado
            req.getRequestDispatcher("/WEB-INF/vistas/nuevoSocio.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("error", "Error al guardar el socio en la base de datos.");
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/nuevoSocio.jsp").forward(req, resp);
        }
    }
}
