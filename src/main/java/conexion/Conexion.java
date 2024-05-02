package conexion;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    public static Connection getConnection() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3308/polloslocos?useSSL=false", "root", "");

        } catch (Exception e) {
            System.out.println(e);
        }
        return cn;
    }
}
