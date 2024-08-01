/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import static conexion.Conexion.getConnection;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao {

    public boolean validarUsuario(Usuario usu) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=? AND password=? AND estado=1");
            ps.setString(1, usu.getEmail());
            ps.setString(2, usu.getPassword());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setRol(rs.getString("rol"));
                usu.setEstado(rs.getInt("estado"));
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Usuario> listarUsuarios() {
        List<Usuario> listaUsuarios = new ArrayList<Usuario>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idUsuario, codigo, email, password, rol, estado FROM usuario ORDER BY idUsuario DESC");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario user = new Usuario();
                user.setIdUsuario(rs.getInt("idUsuario"));
                user.setCodigo(rs.getString("codigo"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
                user.setEstado(rs.getInt("estado"));
                listaUsuarios.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaUsuarios;
    }
    public static List<Usuario> listarUsuariosPagina(int start, int total) {
        List<Usuario> listaUsuarios = new ArrayList<Usuario>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idUsuario, codigo, email, password, rol, estado FROM usuario WHERE estado = 1 ORDER BY idUsuario DESC LIMIT ?, ?");
            ps.setInt(1, start - 1);
            ps.setInt(2, total);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario user = new Usuario();
                user.setIdUsuario(rs.getInt("idUsuario"));
                user.setCodigo(rs.getString("codigo"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
                user.setEstado(rs.getInt("estado"));
                listaUsuarios.add(user);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaUsuarios;
    }

    public static int contarUsuarios() {
        int totalUsuarios = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS total FROM usuario WHERE estado = 1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalUsuarios = rs.getInt("total");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalUsuarios;
    }
    
    public static int contarUsuariosAnulados() {
        int totalUsuarios = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS total FROM usuario WHERE estado = 0");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalUsuarios = rs.getInt("total");
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return totalUsuarios;
    }

        // Registro actualizado
    public static int registrarUsuario(Usuario usu) {
        int idRegistrado = 0;
        try {
            Connection con = getConnection();
            String query = "INSERT INTO usuario (email,password,rol,estado) VALUES (?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, usu.getEmail());
            ps.setString(2, usu.getPassword());
            ps.setString(3, usu.getRol());
            ps.setInt(4, usu.getEstado());
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idRegistrado = rs.getInt(1);
                
                String codigo = "U" + String.format("%04d", idRegistrado);
                
                ps = con.prepareStatement("UPDATE usuario SET codigo=? WHERE idUsuario=?");
                ps.setString(1, codigo);
                ps.setInt(2, idRegistrado);
                ps.executeUpdate();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return idRegistrado;
    }
    
    // Actualizar registro para insertar codigo
    /*public static int AgregarCodigo(int idUsuario, String code) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE usuario SET codigo=? WHERE idUsuario=?");
            ps.setString(1, code);
            ps.setInt(2, idUsuario);
            estado = ps.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
        return estado;
    }*/
    
    public boolean validarEmail(String email) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
            
        } catch (Exception e) {

        }
        return false;
    }
    
    public boolean validarUsuarioInactivo(Usuario usu) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=? AND password=? AND estado=0");
            ps.setString(1, usu.getEmail());
            ps.setString(2, usu.getPassword());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setRol(rs.getString("rol"));
                usu.setEstado(rs.getInt("estado"));
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int actualizarUsuario(Usuario usu) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE usuario SET password=?, rol=? WHERE idUsuario=?");
            //PreparedStatement ps = con.prepareStatement("UPDATE usuario SET codigo=?, email=?, password=?, rol=?, estado=? WHERE idUsuario=?");
            //ps.setString(1, usu.getCodigo());
            //ps.setString(2, usu.getEmail());
            ps.setString(1, usu.getPassword());
            ps.setString(2, usu.getRol());
            //ps.setInt(5, usu.getEstado());
            ps.setInt(3, usu.getIdUsuario());
            System.out.println("Prueba");
            est= ps.executeUpdate();
        } catch (Exception e){
            System.out.println(e);
        }
        return est;
    }
    
    public static Usuario obtenerUsuarioPorId(int idUsuario) {
        Usuario usuario = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idUsuario, codigo, email, password, rol, estado FROM usuario WHERE idUsuario = ?");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setCodigo(rs.getString("codigo"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getInt("estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuario;
    }
    
    public static int anularUsuario(Usuario usu) {
        int est = 0;
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = getConnection();
            // Iniciar Transacción (Todos los SQL deben ejecutarse)
            con.setAutoCommit(false);
            
            // Actualizar el estado del usuario
            ps = con.prepareStatement("UPDATE usuario SET estado = 0 WHERE idUsuario = ?");
            ps.setInt(1, usu.getIdUsuario());
            est = ps.executeUpdate();

            // Confirmar la transacción
            con.commit();
            
        } catch (Exception e) {
            System.out.println(e);
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        return est;
    }
    
    public static List<Usuario> listarUsuariosAnuladosPagina(int start, int total) {
        List<Usuario> listaUsuarios = new ArrayList<Usuario>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idUsuario, codigo, email, password, rol, estado FROM usuario WHERE estado=0 ORDER BY idUsuario DESC LIMIT ?, ?");
            ps.setInt(1, start-1);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Usuario user = new Usuario();
                user.setIdUsuario(rs.getInt("idUsuario"));
                user.setCodigo(rs.getString("codigo"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRol(rs.getString("rol"));
                user.setEstado(rs.getInt("estado"));
                listaUsuarios.add(user);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return listaUsuarios;
    }
    
    public static List<Usuario> listarUsuariosAnulados() {
        List<Usuario> listaUsuariosAnulados = new ArrayList<Usuario>();
    try {
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT idUsuario, codigo, email, password, rol, estado FROM usuario WHERE estado = 0 ORDER BY idUsuario DESC");
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Usuario user = new Usuario();
            user.setIdUsuario(rs.getInt("idUsuario"));
            user.setCodigo(rs.getString("codigo"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setRol(rs.getString("rol"));
            user.setEstado(rs.getInt("estado"));
            listaUsuariosAnulados.add(user);
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return listaUsuariosAnulados;
    }
    
    public static int activarUsuario(Usuario usu) {
   int est = 1;
   try {
       Connection con = getConnection();
       PreparedStatement ps = con.prepareStatement("UPDATE usuario SET estado=? WHERE idUsuario=?");
       
       con.setAutoCommit(false);
       
       ps.setInt(1, usu.getEstado());
       ps.setInt(2, usu.getIdUsuario());
       
       est = ps.executeUpdate();
       
       con.commit();
   } catch (SQLException e) {
        // Manejar la excepción SQL adecuadamente
        e.printStackTrace();
    } catch (Exception e) {
        // Manejar cualquier otra excepción
        e.printStackTrace();
    }
    return est;
   }
}
