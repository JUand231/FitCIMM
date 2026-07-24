package fitcimm.dao;

import fitcimm.modelo.Membresia;
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
                    m.setNombrePlan(rs.getString("nombre_plan"));
                    m.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                    m.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                    m.setValorPagado(rs.getDouble("valor_pagado"));
                    lista.add(m);
                }
            }
            return lista;
        }
    }

    public boolean tieneMembresiaVigente(int idSocio) throws SQLException {
        String consulta = "SELECT 1"
                + "FROM membresia"
                + "WGERE id_socio = ?"
                + "AND CURDATE() BETWEEN fecha_inicio AND fecha_fin";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }

    }
}
