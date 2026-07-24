package fitcimm.servicio;

import fitcimm.dao.IngresoDAO;
import java.sql.SQLException;
import java.time.LocalDate;
import fitcimm.modelo.Ingreso;
import java.util.List;

public class IngresoServicio {

    private IngresoDAO dao = new IngresoDAO();

    public boolean ingresoRegistrado(int idSocio) throws SQLException {
        return dao.ingresoRegistrado(idSocio);
    }

    public boolean registrarIngreso(int idSocio) throws SQLException {
        return dao.registrarIngreso(idSocio);
    }

    public List<Ingreso> consultarPorFecha(LocalDate fecha) throws SQLException {
        return dao.consultarPorFecha(fecha);
    }
}