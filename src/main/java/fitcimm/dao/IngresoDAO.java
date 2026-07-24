package fitcimm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class IngresoDAO {
    public boolean ingresoRegistrado(int idSocio) throws SQLException {
        
        String consulta =
                "SELECT 1 FROM ingreso" +
                "WHERE id_socio = ?" +
                "AND fecha_ingreso = CURDATE()";
        try(Connection con = ConexionDB.getConexion();
            PreparedStatement ps = con.prepareStatement(consulta)){
            
            ps.setInt(1, idSocio);
            try(ResultSet rs = ps.executeQuery()){
                return rs.next();
            }
            
        }
    }
    
}
