package fitcimm.controlador;

import fitcimm.modelo.Membresia;
import fitcimm.modelo.Socio;
import fitcimm.servicio.MembresiaServicio;
import fitcimm.servicio.NegocioException;
import fitcimm.servicio.SocioServicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/socios/*")
public class SocioServlet extends HttpServlet {

    private SocioServicio socioServicio = new SocioServicio();
    private MembresiaServicio membresiaServicio = new MembresiaServicio();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String accion = req.getPathInfo();

        if (accion == null || accion.equals("/") || accion.isEmpty()) {
            listar(req, resp);
        } else if (accion.equals("/nuevo")) {
            req.getRequestDispatcher("/WEB-INF/vistas/NuevoSocio.jsp").forward(req, resp);
        } else if (accion.equals("/editar")) {
            mostrarFormularioEditar(req, resp);
        } else if (accion.equals("/detalle")) {
            verDetalle(req, resp);
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
        } else if (accion != null && accion.equals("/editar")) {
            actualizar(req, resp);
        } else if (accion != null && accion.equals("/inactivar")) {
            inactivar(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // LISTAR / BUSCAR
    private void listar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String busqueda = req.getParameter("busqueda");
            List<Socio> listaSocios;

            if (busqueda != null && !busqueda.trim().isEmpty()) {
                listaSocios = socioServicio.buscarSocio(busqueda);
            } else {
                listaSocios = socioServicio.listarSocios();
            }

            req.setAttribute("listaSocios", listaSocios);

        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/vistas/SocioVista.jsp").forward(req, resp);
    }

    // REGISTRAR
    private void registrar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Socio socio = leerSocioDelFormulario(req, false);

        try {
            socioServicio.registrarSocio(socio);
            resp.sendRedirect(req.getContextPath() + "/socios");

        } catch (NegocioException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/NuevoSocio.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("error", "Error al guardar el socio en la base de datos.");
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/NuevoSocio.jsp").forward(req, resp);
        }
    }

    // MOSTRAR FORMULARIO DE EDICION
    private void mostrarFormularioEditar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));
            Socio socio = socioServicio.consultarDetalle(idSocio);
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/EditarSocio.jsp").forward(req, resp);

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/socios");
        }
    }

    // ACTUALIZAR
    private void actualizar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Socio socio = leerSocioDelFormulario(req, true);

        try {
            socioServicio.editarSocio(socio);
            resp.sendRedirect(req.getContextPath() + "/socios");

        } catch (NegocioException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/EditarSocio.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("error", "Error al actualizar el socio.");
            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/WEB-INF/vistas/EditarSocio.jsp").forward(req, resp);
        }
    }

    // VER DETALLE + HISTORIAL DE MEMBRESIAS
    private void verDetalle(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));

            Socio socio = socioServicio.consultarDetalle(idSocio);
            List<Membresia> historial = membresiaServicio.listarPorSocio(idSocio);

            req.setAttribute("socio", socio);
            req.setAttribute("historial", historial);
            req.getRequestDispatcher("/WEB-INF/vistas/DetalleSocio.jsp").forward(req, resp);

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/socios");
        }
    }

    // INACTIVAR (borrado logico, RN-05 y RN-10)
    private void inactivar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            int idSocio = Integer.parseInt(req.getParameter("id"));
            socioServicio.inactivarSocio(idSocio);

        } catch (Exception e) {
            
        }

        resp.sendRedirect(req.getContextPath() + "/socios");
    }

    // Helper: arma un objeto Socio con los datos que vienen del formulario.
    // conId=true cuando es edicion, porque ahi si viaja el idSocio en el POST.
    private Socio leerSocioDelFormulario(HttpServletRequest req, boolean conId) {

        Socio socio = new Socio();

        if (conId) {
            socio.setIdSocio(Integer.parseInt(req.getParameter("idSocio")));
            socio.setDocumento(req.getParameter("documento")); // solo lectura en la vista
        } else {
            socio.setDocumento(req.getParameter("documento"));
        }

        socio.setNombres(req.getParameter("nombres"));
        socio.setApellidos(req.getParameter("apellidos"));
        socio.setTelefono(req.getParameter("telefono"));
        socio.setCorreo(req.getParameter("correo"));

        String fechaTexto = req.getParameter("fechaNacimiento");
        if (fechaTexto != null && !fechaTexto.isBlank()) {
            socio.setFechaNacimiento(LocalDate.parse(fechaTexto));
        }

        return socio;
    }
}
