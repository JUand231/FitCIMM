package fitcimm.dao;

import fitcimm.modelo.Plan;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {

    public Plan buscarPorId(int idPlan) throws SQLException {

        String consulta = "SELECT * FROM plan WHERE id_plan = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idPlan);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Plan plan = new Plan();

                    plan.setIdPlan(rs.getInt("id_plan"));
                    plan.setNombre(rs.getString("nombre"));
                    plan.setDuracionDias(rs.getInt("duracion_dias"));
                    plan.setValor(rs.getDouble("valor"));
                    plan.setActivo(rs.getBoolean("activo"));

                    return plan;
                }
            }
        }

        return null;
    }

    public boolean registrarPlan(Plan plan) throws SQLException {

        String consulta = "INSERT INTO plan (nombre, duracion_dias, valor, activo) VALUES (?,?,?,?)";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setDouble(3, plan.getValor());
            ps.setBoolean(4, plan.isActivo());

            return ps.executeUpdate() > 0;
        }
    }

    public List<Plan> listarPlanes() throws SQLException {

        List<Plan> lista = new ArrayList<>();

        String consulta = "SELECT * FROM plan";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Plan plan = new Plan();

                plan.setIdPlan(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                plan.setDuracionDias(rs.getInt("duracion_dias"));
                plan.setValor(rs.getDouble("valor"));
                plan.setActivo(rs.getBoolean("activo"));

                lista.add(plan);
            }
        }

        return lista;
    }

    public boolean actualizarPlan(Plan plan) throws SQLException {

        String consulta = "UPDATE plan SET nombre=?, duracion_dias=?, valor=? WHERE id_plan=?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setDouble(3, plan.getValor());
            ps.setInt(4, plan.getIdPlan());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean cambiarEstado(int idPlan, boolean activo) throws SQLException {

        String consulta = "UPDATE plan SET activo=? WHERE id_plan=?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setBoolean(1, activo);
            ps.setInt(2, idPlan);

            return ps.executeUpdate() > 0;
        }
    }

}
