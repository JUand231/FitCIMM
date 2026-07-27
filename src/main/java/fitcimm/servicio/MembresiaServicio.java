package fitcimm.servicio;

import fitcimm.dao.MembresiaDAO;
import fitcimm.dao.PlanDAO;
import fitcimm.dao.SocioDAO;
import fitcimm.modelo.Membresia;
import fitcimm.modelo.Plan;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class MembresiaServicio {

    private MembresiaDAO dao = new MembresiaDAO();
    private SocioDAO socioDAO = new SocioDAO();
    private PlanDAO planDAO = new PlanDAO();

    public List<Membresia> listarPorSocio(int idSocio) throws SQLException {
        return dao.listarPorSocio(idSocio);
    }

    public boolean registrarMembresia(Membresia membresia) throws SQLException {

        if (membresia == null) {
            return false;
        }

        if (socioDAO.buscarPorId(membresia.getIdSocio()) == null) {
            return false;
        }

        Plan plan = planDAO.buscarPorId(membresia.getIdPlan());

        if (plan == null) {
            return false;
        }

        Membresia ultima = dao.buscarUltimaMembresia(membresia.getIdSocio());

        LocalDate fechaInicio;

        if (ultima == null) {
            fechaInicio = LocalDate.now();
        } else {

            if (ultima.getFechaFin().isAfter(LocalDate.now())) {
                fechaInicio = ultima.getFechaFin().plusDays(1);
            } else {
                fechaInicio = LocalDate.now();
            }

        }

        LocalDate fechaFin = fechaInicio.plusDays(plan.getDuracionDias() - 1);

        membresia.setFechaInicio(fechaInicio);
        membresia.setFechaFin(fechaFin);
        membresia.setValorPagado(plan.getValor());

        return dao.registrarMembresia(membresia);
    }

    public List<Membresia> listarMembresias() throws SQLException {
        return dao.listarMembresias();
    }

    public Membresia buscarPorId(int idMembresia) throws SQLException {
        return dao.buscarPorId(idMembresia);
    }

    public Membresia buscarUltimaMembresia(int idSocio) throws SQLException {
        return dao.buscarUltimaMembresia(idSocio);
    }

    public List<Membresia> listarProximasAVencer() throws SQLException {
        return dao.listarProximasAVencer();

    }

}
