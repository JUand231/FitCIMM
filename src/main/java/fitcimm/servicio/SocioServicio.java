package fitcimm.servicio;

import fitcimm.dao.SocioDAO;
import fitcimm.modelo.Socio;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

public class SocioServicio {

    private SocioDAO dao = new SocioDAO();

    public void registrarSocio(Socio socio) throws SQLException, NegocioException {

        if (socio.getDocumento() == null || socio.getDocumento().isBlank()) {
            throw new NegocioException("El documento es obligatorio.");
        }
        if (socio.getNombres() == null || socio.getNombres().isBlank()) {
            throw new NegocioException("Los nombres son obligatorios.");
        }
        if (socio.getApellidos() == null || socio.getApellidos().isBlank()) {
            throw new NegocioException("Los apellidos son obligatorios.");
        }
        if (socio.getFechaNacimiento() == null) {
            throw new NegocioException("La fecha de nacimiento es obligatoria.");
        }

        // RN-09: mayor de 15 años
        int edad = Period.between(socio.getFechaNacimiento(), LocalDate.now()).getYears();
        if (edad < 15) {
            throw new NegocioException("El socio debe ser mayor de 15 años.");
        }

        // RN-01: documento único
        if (dao.existeDocumento(socio.getDocumento())) {
            throw new NegocioException("Ya existe un socio con ese documento.");
        }

        socio.setActivo(true);
        dao.registrarSocio(socio);
    }

    public List<Socio> listarSocios() throws SQLException {
        return dao.listarSocios();
    }

    public Socio consultarDetalle(int idSocio) throws SQLException, NegocioException {
        Socio socio = dao.buscarPorId(idSocio);
        if (socio == null) {
            throw new NegocioException("No existe un socio con ese identificador.");
        }
        return socio;
    }

    public void editarSocio(Socio socio) throws SQLException, NegocioException {

        if (socio.getNombres() == null || socio.getNombres().isBlank()) {
            throw new NegocioException("Los nombres son obligatorios.");
        }
        if (socio.getApellidos() == null || socio.getApellidos().isBlank()) {
            throw new NegocioException("Los apellidos son obligatorios.");
        }
        if (socio.getFechaNacimiento() == null) {
            throw new NegocioException("La fecha de nacimiento es obligatoria.");
        }

        // RN-09: revalida edad, por si la cambian
        int edad = Period.between(socio.getFechaNacimiento(), LocalDate.now()).getYears();
        if (edad < 15) {
            throw new NegocioException("El socio debe ser mayor de 15 años.");
        }

        boolean actualizado = dao.actualizarSocio(socio);
        if (!actualizado) {
            throw new NegocioException("No se encontró el socio a actualizar.");
        }
    }

    public void inactivarSocio(int idSocio) throws SQLException, NegocioException {
        boolean resultado = dao.cambiarEstadoSocio(idSocio, false);
        if (!resultado) {
            throw new NegocioException("No se encontró el socio a inactivar.");
        }
    }

    public List<Socio> buscarSocio(String busqueda) throws SQLException {
        return dao.buscarSocio(busqueda);
    }

    public Socio ingresoPorDocumento(String documento) throws SQLException {
        return dao.ingresoPorDocumento(documento);
    }

    public List<Socio> listarProximoVencer() throws SQLException {
        return dao.listarProximoVencer();
    }
}
