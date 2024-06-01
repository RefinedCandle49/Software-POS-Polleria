/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Cliente;
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

    public static Cliente listarClientePorId(String documento){
        Cliente cliente = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, documento, nombre, apellido FROM cliente WHERE documento = ?");
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

}
