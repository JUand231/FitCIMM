package fitcimm.dao;

import fitcimm.modelo.Membresia;
import fitcimm.modelo.Plan;
import fitcimm.modelo.Socio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MembresiaDAO {

    public List<Membresia> listarPorSocio(int idSocio) throws SQLException {
        String consulta = "Select m.id_membresia, m.id_socio, m.id_plan, p.nombre AS nombre_plan, "
                + "m.fecha_inicio, m.fecha_fin, m.valor_pagado "
                + "From membresia m "
                + "Join plan p ON m.id_plan = p.id_plan "
                + "Where m.id_socio = ? "
                + "Order by m.fecha_inicio Desc";

        List<Membresia> lista = new ArrayList<>();

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Membresia m = new Membresia();
                    m.setIdMembresia(rs.getInt("id_membresia"));
                    m.setIdSocio(rs.getInt("id_socio"));
                    m.setIdPlan(rs.getInt("id_plan"));
                    m.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                    m.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                    m.setValorPagado(rs.getDouble("valor_pagado"));

                    Plan plan = new Plan();
                    plan.setIdPlan(rs.getInt("id_plan"));
                    plan.setNombre(rs.getString("nombre_plan"));
                    m.setPlan(plan);

                    lista.add(m);
                }
            }
            return lista;
        }
    }

    public boolean registrarMembresia(Membresia membresia) throws SQLException {

        String consulta = "INSERT INTO membresia (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado) values (?,?,?,?,?)";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, membresia.getIdSocio());
            ps.setInt(2, membresia.getIdPlan());
            ps.setDate(3, Date.valueOf(membresia.getFechaInicio()));
            ps.setDate(4, Date.valueOf(membresia.getFechaFin()));
            ps.setDouble(5, membresia.getValorPagado());

            return ps.executeUpdate() > 0;

        }
    }

    public List<Membresia> listarMembresias() throws SQLException {
        List<Membresia> lista = new ArrayList<>();

        String consulta = "SELECT m.*,s.nombres,s.apellidos,s.documento,p.nombre FROM membresia m"
                + " JOIN socio s ON s.id_socio = m.id_socio"
                + " JOIN plan p ON p.id_plan = m.id_plan";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Membresia membresia = new Membresia();

                membresia.setIdMembresia(rs.getInt("id_membresia"));
                membresia.setIdSocio(rs.getInt("id_socio"));
                membresia.setIdPlan(rs.getInt("id_plan"));
                membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                membresia.setValorPagado(rs.getDouble("valor_pagado"));

                Socio socio = new Socio();
                socio.setDocumento(rs.getString("documento"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));

                membresia.setSocio(socio);
                Plan plan = new Plan();
                plan.setNombre(rs.getString("nombre"));

                membresia.setPlan(plan);

                lista.add(membresia);
            }
        }
        return lista;
    }

    public Membresia buscarPorId(int idMembresia) throws SQLException {

        String consulta = "SELECT * FROM membresia WHERE id_membresia = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idMembresia);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Membresia m = new Membresia();
                    m.setIdMembresia(rs.getInt("id_membresia"));
                    m.setIdSocio(rs.getInt("id_socio"));
                    m.setIdPlan(rs.getInt("id_plan"));
                    m.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                    m.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                    m.setValorPagado(rs.getDouble("valor_pagado"));

                    return m;
                }
            }
        }
        return null;
    }

    public Membresia buscarUltimaMembresia(int idSocio) throws SQLException {

        String consulta = "SELECT * FROM membresia WHERE id_socio = ? ORDER BY fecha_fin DESC LIMIT 1";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Membresia m = new Membresia();
                    m.setIdMembresia(rs.getInt("id_membresia"));
                    m.setIdSocio(rs.getInt("id_socio"));
                    m.setIdPlan(rs.getInt("id_plan"));
                    m.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                    m.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                    m.setValorPagado(rs.getDouble("valor_pagado"));

                    return m;
                }
            }
        }
        return null;
    }

    public List<Membresia> listarProximasAVencer() throws SQLException {

        List<Membresia> lista = new ArrayList<>();

        String consulta = "SELECT m.*, s.documento, s.nombres, s.apellidos, s.telefono, p.nombre "
                + "FROM membresia m "
                + "JOIN socio s ON m.id_socio = s.id_socio "
                + "JOIN plan p ON m.id_plan = p.id_plan "
                + "WHERE m.fecha_fin BETWEEN CURDATE() "
                + "AND DATE_ADD(CURDATE(), INTERVAL 5 DAY)";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Membresia membresia = new Membresia();

                membresia.setIdMembresia(rs.getInt("id_membresia"));
                membresia.setIdSocio(rs.getInt("id_socio"));
                membresia.setIdPlan(rs.getInt("id_plan"));
                membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                membresia.setValorPagado(rs.getDouble("valor_pagado"));

                Socio socio = new Socio();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setDocumento(rs.getString("documento"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                socio.setTelefono(rs.getString("telefono"));
                membresia.setSocio(socio);

                Plan plan = new Plan();
                plan.setIdPlan(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));

                membresia.setPlan(plan);

                lista.add(membresia);
            }
            return lista;
        }

    }

    public boolean tieneMembresiaVigente(int idSocio) throws SQLException {

        String consulta
                = "SELECT 1 "
                + "FROM membresia "
                + "WHERE id_socio = ? "
                + "AND CURDATE() BETWEEN fecha_inicio AND fecha_fin";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

}
