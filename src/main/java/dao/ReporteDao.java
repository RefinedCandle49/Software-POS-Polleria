/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static conexion.Conexion.getConnection;
import model.DetalleVenta;
import model.Producto;

/**
 *
 * @author daniel
 */
public class ReporteDao {

    public DetalleVenta obtenerProductoMasVendido(int year) {
        DetalleVenta productoVendido = null;

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT dp.idProducto, p.nombre AS nombre_producto, SUM(dp.cantidad) AS total_vendido FROM detalleventa dp INNER JOIN producto p ON dp.idProducto = p.idProducto INNER JOIN venta vt ON dp.idVenta = vt.idVenta WHERE YEAR(vt.fechaHoraVenta)=? AND vt.estado=1 GROUP BY dp.idProducto, p.nombre ORDER BY total_vendido DESC LIMIT 1;");
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()) {
                int idProducto = rs.getInt("idProducto");
                String nombreProducto = rs.getString("nombre_producto");
                int totalVenta = rs.getInt("total_vendido");
                productoVendido = new DetalleVenta(idProducto, nombreProducto, totalVenta);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return productoVendido;
    }

}
