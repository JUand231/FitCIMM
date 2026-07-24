package fitcimm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import fitcimm.modelo.Ingreso;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class IngresoDAO {

    public boolean ingresoRegistrado(int idSocio) throws SQLException {

        String consulta
                = "SELECT 1 FROM ingreso "
                + "WHERE id_socio = ? "
                + "AND fecha_ingreso = CURDATE()";
        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean registrarIngreso(int idSocio) throws SQLException {

        String consulta
                = "INSERT INTO ingreso(id_socio, fecha_ingreso, hora_ingreso) "
                + "VALUES(?, CURDATE(), CURTIME())";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);

            return ps.executeUpdate() > 0;

        }
    }

    public List<Ingreso> consultarPorFecha(LocalDate fecha) throws SQLException {

        List<Ingreso> lista = new ArrayList<>();

        String consulta =
            "SELECT * FROM ingreso " +
            "WHERE fecha_ingreso = ? " +
            "ORDER BY hora_ingreso";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setDate(1, java.sql.Date.valueOf(fecha));

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Ingreso ingreso = new Ingreso();

                    ingreso.setIdIngreso(rs.getInt("id_ingreso"));
                    ingreso.setIdSocio(rs.getInt("id_socio"));
                    ingreso.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
                    ingreso.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());

                    lista.add(ingreso);

                }
            }
        }

        return lista;
    }
}