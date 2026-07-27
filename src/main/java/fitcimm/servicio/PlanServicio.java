package fitcimm.servicio;

import fitcimm.dao.PlanDAO;
import fitcimm.modelo.Plan;

import java.sql.SQLException;
import java.util.List;

public class PlanServicio {

    private PlanDAO dao = new PlanDAO();

    public boolean registrarPlan(Plan plan) throws SQLException {

        if (plan == null) {
            return false;
        }

        if (plan.getNombre() == null || plan.getNombre().isBlank()) {
            return false;
        }

        if (plan.getDuracionDias() <= 0) {
            return false;
        }

        if (plan.getValor() <= 0) {
            return false;
        }
        plan.setActivo(true);

        return dao.registrarPlan(plan);
    }

    public List<Plan> listarPlanes() throws SQLException {
        return dao.listarPlanes();
    }

    public Plan buscarPorId(int idPlan) throws SQLException {
        return dao.buscarPorId(idPlan);
    }

    public boolean editarPlan(Plan plan) throws SQLException {

        if (plan == null) {
            return false;
        }

        if (plan.getNombre() == null || plan.getNombre().isBlank()) {
            return false;
        }

        if (plan.getDuracionDias() <= 0) {
            return false;
        }

        if (plan.getValor() <= 0) {
            return false;
        }

        return dao.actualizarPlan(plan);
    }

    public boolean cambiarEstado(int idPlan, boolean activo) throws SQLException {
        return dao.cambiarEstado(idPlan, activo);
    }

}
