package fitcimm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import fitcimm.modelo.Ingreso;
import fitcimm.modelo.ConsultaIngreso;
import java.sql.Date;
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

    public List<ConsultaIngreso> listarIngresos() throws SQLException {

        List<ConsultaIngreso> lista = new ArrayList<>();

        String consulta
                = "SELECT s.documento, s.nombres, s.apellidos, "
                + "i.fecha_ingreso, i.hora_ingreso "
                + "FROM ingreso i "
                + "INNER JOIN socio s ON i.id_socio = s.id_socio "
                + "ORDER BY i.fecha_ingreso DESC, i.hora_ingreso DESC";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                ConsultaIngreso ingreso = new ConsultaIngreso();

                ingreso.setDocumento(rs.getString("documento"));
                ingreso.setNombres(rs.getString("nombres"));
                ingreso.setApellidos(rs.getString("apellidos"));
                ingreso.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
                ingreso.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());

                lista.add(ingreso);
            }
        }

        return lista;
    }

    public List<ConsultaIngreso> consultarPorFecha(LocalDate fecha) throws SQLException {

        List<ConsultaIngreso> lista = new ArrayList<>();

        String consulta
                = "SELECT s.documento, s.nombres, s.apellidos, "
                + "i.fecha_ingreso, i.hora_ingreso "
                + "FROM ingreso i "
                + "INNER JOIN socio s ON i.id_socio = s.id_socio "
                + "WHERE i.fecha_ingreso = ? "
                + "ORDER BY i.hora_ingreso";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setDate(1, Date.valueOf(fecha));

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    ConsultaIngreso ingreso = new ConsultaIngreso();

                    ingreso.setDocumento(rs.getString("documento"));
                    ingreso.setNombres(rs.getString("nombres"));
                    ingreso.setApellidos(rs.getString("apellidos"));
                    ingreso.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
                    ingreso.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());

                    lista.add(ingreso);
                }
            }
        }

        return lista;
    }
}
