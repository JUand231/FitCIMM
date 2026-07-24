package fitcimm.servicio;

import fitcimm.dao.SocioDAO;
import fitcimm.modelo.Socio;
import java.sql.SQLException;
import java.util.List;

public class SocioServicio {

    private SocioDAO dao = new SocioDAO();

    public boolean registrarSocio(Socio socio) throws SQLException {

        if (socio.getDocumento().isBlank()) {
            return false;
        }
        if (socio.getNombres().isBlank()) {
            return false;
        }
        if (dao.existeDocumento(socio.getDocumento())) {
            return false;
        }

        return dao.registrarSocio(socio);
    }

    public List<Socio> listarSocios() throws SQLException {
        return dao.listarSocios();
    }

    public Socio consultarDetalle(int idSocio) throws SQLException {
        return dao.buscarPorId(idSocio);
    }

    public boolean editarSocio(Socio socio) throws SQLException {
        return dao.actualizarSocio(socio);
    }

    public boolean inactivarSocio(int idSocio) throws SQLException {
        return dao.cambiarEstadoSocio(idSocio, false);
    }

    public List<Socio> buscarSocio(String busqueda) throws SQLException {
        return dao.buscarSocio(busqueda);
    }

    public Socio IngresoPorDocumento(String documento) throws SQLException {
        return dao.IngresoPorDocumento(documento);
    }

    public List<Socio> listarProximoVencer() throws SQLException {
        return dao.listarProximoVencer();
    }
}
