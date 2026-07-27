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

@WebServlet("/socios/editar")
public class EditarSocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();

    // Muestra el formulario con los datos actuales
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));
            Socio socio = socioServicio.consultarDetalle(idSocio);
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/editarSocio.jsp").forward(req, resp);

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/socios");
        }
    }

    // Procesa el formulario
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Socio socio = new Socio();
        socio.setIdSocio(Integer.parseInt(req.getParameter("idSocio")));
        socio.setDocumento(req.getParameter("documento")); // solo lectura en la vista, no se edita
        socio.setNombres(req.getParameter("nombres"));
        socio.setApellidos(req.getParameter("apellidos"));
        socio.setTelefono(req.getParameter("telefono"));
        socio.setCorreo(req.getParameter("correo"));

        String fechaTexto = req.getParameter("fechaNacimiento");
        if (fechaTexto != null && !fechaTexto.isBlank()) {
            socio.setFechaNacimiento(LocalDate.parse(fechaTexto));
        }

        try {
            socioServicio.editarSocio(socio);
            resp.sendRedirect(req.getContextPath() + "/socios");

        } catch (NegocioException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/editarSocio.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("error", "Error al actualizar el socio.");
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/editarSocio.jsp").forward(req, resp);
        }
    }
}
