package fitcimm.dao;

import fitcimm.modelo.Membresia;
import fitcimm.modelo.Socio;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;

public class SocioDAO {

    public boolean registrarSocio(Socio socio) throws SQLException {

        String consulta = "Insert into socio(documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo) values (?,?,?,?,?,?,?)";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, socio.getDocumento());
            ps.setString(2, socio.getNombres());
            ps.setString(3, socio.getApellidos());
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getCorreo());
            ps.setDate(6, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setBoolean(7, socio.isActivo());

            return ps.executeUpdate() > 0;

        }
    }

    public List<Socio> listarSocios() throws SQLException {
        List<Socio> lista = new ArrayList<>();

        String consulta = "Select * from socio";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Socio socio = new Socio();

                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setDocumento(rs.getString("documento"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                socio.setTelefono(rs.getString("telefono"));
                socio.setCorreo(rs.getString("correo"));
                socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                socio.setActivo(rs.getBoolean("activo"));

                lista.add(socio);
            }
        }
        return lista;
    }

    public Socio buscarPorId(int idSocio) throws SQLException {

        String consulta = "Select * from socio where id_socio = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Socio s = new Socio();
                    s.setIdSocio(rs.getInt("id_socio"));
                    s.setDocumento(rs.getString("documento"));
                    s.setNombres(rs.getString("nombres"));
                    s.setApellidos(rs.getString("apellidos"));
                    s.setTelefono(rs.getString("telefono"));
                    s.setCorreo(rs.getString("correo"));
                    s.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    s.setActivo(rs.getBoolean("activo"));
                    return s;
                }
            }
        }
        return null;
    }

    public boolean actualizarSocio(Socio socio) throws SQLException {
        String consulta = "Update socio Set nombres=?, apellidos=?, telefono=?, correo=?, fecha_nacimiento=? where id_socio=?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(2, socio.getNombres());
            ps.setString(3, socio.getApellidos());
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getCorreo());
            ps.setDate(6, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setInt(7, socio.getIdSocio());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean cambiarEstadoSocio(int idSocio, boolean activo) throws SQLException {
        boolean resultado = false;

        String consulta = "Update socio Set activo = ? Where id_socio = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setBoolean(1, activo);
            ps.setInt(2, idSocio);

            resultado = ps.executeUpdate() > 0;
        }
        return resultado;
    }

    public List<Socio> buscarSocio(String busqueda) throws SQLException {
        List<Socio> lista = new ArrayList<>();

        String consulta = "Select * from socio where documento = ? or apellidos like?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, busqueda);
            ps.setString(2, "%" + busqueda + "%");

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Socio socio = new Socio();

                    socio.setIdSocio(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombres(rs.getString("nombres"));
                    socio.setApellidos(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    socio.setActivo(rs.getBoolean("activo"));

                    lista.add(socio);
                }
                return lista;
            }
        }
    }

    public Socio IngresoPorDocumento(String documento) throws SQLException {

        String consulta = "SELECT * FROM socio WHERE documento = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, documento);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Socio socio = new Socio();

                    socio.setIdSocio(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombres(rs.getString("nombres"));
                    socio.setApellidos(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    socio.setActivo(rs.getBoolean("activo"));

                    return socio;
                }
            }
        }
        return null;
    }

    public List<Socio> listarProximoVencer() throws SQLException {

        List<Socio> lista = new ArrayList<>();

        String consulta = "Select * From socio s Join Membresia M on M.id_socio = s.id_socio Where M.fecha_fin Between Curdate() And Date_add(Curdate(), Interval 5 Day)";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Socio socio = new Socio();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setDocumento(rs.getString("documento"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                socio.setTelefono(rs.getString("telefono"));
                socio.setCorreo(rs.getString("correo"));
                socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                socio.setActivo(rs.getBoolean("activo"));

                Membresia membresia = new Membresia();
                membresia.setIdMembresia(rs.getInt("id_membresia"));
                membresia.setIdSocio(rs.getInt("id_socio"));
                membresia.setIdPlan(rs.getInt("id_plan"));
                membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                membresia.setValorPagado(rs.getDouble("valor_pagado"));

                socio.setMembresia(membresia);

                lista.add(socio);
            }
        }
        return lista;
    }

    public boolean existeDocumento(String documento) throws SQLException {
        String consulta = "SELECT COUNT(*) FROM socio WHERE documento = ?";

        try (Connection con = ConexionDB.getConexion(); PreparedStatement ps = con.prepareStatement(consulta)) {

            ps.setString(1, documento);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }
}
