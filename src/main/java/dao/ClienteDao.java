/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cliente;
import model.Producto;

/**
 *
 * @author daniel
 */
public class ClienteDao {

    public static List<Cliente> listarClientes() {
        List<Cliente> listaClientes = new ArrayList<Cliente>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, documento, nombre, apellido, email, estado FROM cliente ORDER BY idCliente DESC");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente cli = new Cliente();
                cli.setIdCliente(rs.getInt("idCliente"));
                cli.setDocumento(rs.getString("documento"));
                cli.setNombre(rs.getString("nombre"));
                cli.setApellido(rs.getString("apellido"));
                cli.setEmail(rs.getString("email"));
                cli.setEstado(rs.getInt("estado"));
                listaClientes.add(cli);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaClientes;
    }

    public static List<Cliente> listarClientesPagina(int start, int total) {
        List<Cliente> listaClientes = new ArrayList<Cliente>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT cli.idCliente, cli.documento, cli.nombre, cli.apellido, cli.email, cli.estado FROM cliente cli WHERE cli.estado=1 ORDER BY idCliente DESC LIMIT ?, ?");
            ps.setInt(1, start-1);
            ps.setInt(2, total);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente cli = new Cliente();
                cli.setIdCliente(rs.getInt("idCliente"));
                cli.setDocumento(rs.getString("documento"));
                cli.setNombre(rs.getString("nombre"));
                cli.setApellido(rs.getString("apellido"));
                cli.setEmail(rs.getString("email"));
                cli.setEstado(rs.getInt("estado"));
                listaClientes.add(cli);

            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaClientes;
    }

    public static int contarClientes(){
        int totalClientes = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS total FROM cliente WHERE estado=1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalClientes = rs.getInt("total");
            }
            con.close();

        } catch (Exception e){

        }
        return totalClientes;
    }

    public static Cliente listarClientePorId(String documento){
        Cliente cliente = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, documento, nombre, apellido FROM cliente WHERE documento = ? AND estado = 1");
            ps.setString(1, documento);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setDocumento(rs.getString("documento"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
            }
        } catch (Exception e){

        }
        return cliente;
    }
    
    public static int registrarCliente(Cliente cli) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO cliente (documento,nombre,apellido,email,estado) VALUES (?,?,?,?,?)");
            ps.setString(1, cli.getDocumento());
            ps.setString(2, cli.getNombre());
            ps.setString(3, cli.getApellido());
            ps.setString(4, cli.getEmail());
            ps.setInt(5, cli.getEstado());
            estado = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return estado;
    }
    
    public boolean validarId(String documento) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cliente WHERE documento=?");
            ps.setString(1, documento);
            ResultSet rs = ps.executeQuery();
            return rs.next();
            
        } catch (Exception e) {

        }
        return false;
    }
    
    public boolean validarEmail(String email) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cliente WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
            
        } catch (Exception e) {

        }
        return false;
    }
    
    public static int actualizarCliente (Cliente cli) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE cliente SET documento=?, nombre=?, apellido=?, email=? WHERE idCliente=?");
            ps.setString(1, cli.getDocumento());
            ps.setString(2, cli.getNombre());
            ps.setString(3, cli.getApellido());
            ps.setString(4, cli.getEmail());
            //ps.setInt(5, cli.getEstado());
            ps.setInt(5, cli.getIdCliente());
            System.out.println ("Prueba");
            est = ps.executeUpdate();
        } catch (Exception e){
            System.out.println(e);
        }
        return est;
    }
    
    public static Cliente obtenerClientePorId(int idCliente) {
        Cliente cliente = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, documento, nombre, apellido, email, estado FROM cliente WHERE idCliente = ?");
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setDocumento(rs.getString("documento"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
                cliente.setEmail(rs.getString("email"));
                cliente.setEstado(rs.getInt("estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cliente;
    }
    
    public boolean validarEmailExcepto(String email, int idCliente) {
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cliente WHERE email=? AND idCliente !=?");
            ps.setString(1, email);
            ps.setInt(2, idCliente);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean validarIdExcepto(String documento, int idCliente) {
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareCall("SELECT * FROM cliente WHERE documento=? AND idCliente !=?");
            ps.setString(1, documento);
            ps.setInt(2, idCliente);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
   public static int anularCliente(Cliente cli) {
    int est = 0;
    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement("UPDATE cliente SET estado=? WHERE idCliente=?")) {
        
        con.setAutoCommit(false);
        
        ps.setInt(1, cli.getEstado());
        ps.setInt(2, cli.getIdCliente());
        
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

   public static int contarClienteAnulados() {
        int totalCliente = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS total FROM cliente WHERE estado = 0");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalCliente = rs.getInt("total");
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return totalCliente;
}
    public static List<Cliente> listarClienteAnuladosPagina(int start, int total) {
        List<Cliente> listaCliente = new ArrayList<Cliente>();
        try {
            Connection con = getConnection();
             
            PreparedStatement ps = con.prepareStatement("SELECT idCliente,documento,nombre,apellido,email,estado FROM cliente WHERE estado = 0 ORDER BY idCliente DESC LIMIT ?, ?");
            ps.setInt(1, start-1);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cliente cli = new Cliente();
                cli.setIdCliente(rs.getInt("idCliente"));
                cli.setDocumento(rs.getString("documento"));
                cli.setNombre(rs.getString("nombre"));
                cli.setApellido(rs.getString("apellido"));
                cli.setEmail(rs.getString("email"));
                cli.setEstado(rs.getInt("estado"));
                listaCliente.add(cli);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return listaCliente;
    }
    
    public static int activarCliente(Cliente cli) {
    int est = 1;
    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement("UPDATE cliente SET estado=? WHERE idCliente=?")) {
        
        con.setAutoCommit(false);
        
        ps.setInt(1, cli.getEstado());
        ps.setInt(2, cli.getIdCliente());
        
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
