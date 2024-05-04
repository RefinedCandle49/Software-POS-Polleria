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
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, nombre, apellido, email FROM cliente");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente cli = new Cliente();
                cli.setIdCliente(rs.getString("idCliente"));
                cli.setNombre(rs.getString("nombre"));
                cli.setApellido(rs.getString("apellido"));
                cli.setEmail(rs.getString("email"));
                listaClientes.add(cli);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaClientes;
    }
    
    public static int registrarCliente(Cliente cli) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO cliente (idCLiente,nombre,apellido,email) VALUES (?,?,?,?)");
            ps.setString(1, cli.getIdCliente());
            ps.setString(2, cli.getNombre());
            ps.setString(3, cli.getApellido());
            ps.setString(4, cli.getEmail());
            estado = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return estado;
    }

}
