package fitcimm.servicio;

import fitcimm.dao.MembresiaDAO;
import fitcimm.modelo.Membresia;
import java.sql.SQLException;
import java.util.List;

public class MembresiaServicio {

    private MembresiaDAO dao = new MembresiaDAO();

    public List<Membresia> listarPorSocio(int idSocio) throws SQLException {
        return dao.listarPorSocio(idSocio);
    }
    
    public boolean tieneMembresiaVigente(int idSocio) throws SQLException {
        return dao.tieneMembresiaVigente(idSocio);
    }

}
