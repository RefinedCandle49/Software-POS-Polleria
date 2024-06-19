/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static conexion.Conexion.getConnection;
import java.util.ArrayList;
import java.util.List;
import model.DetalleVenta;
import model.Producto;
import model.Venta;

/**
 *
 * @author daniel
 */
public class ReporteDao {

    public DetalleVenta obtenerProductoMasVendido() {
        DetalleVenta productoVendido = null;

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT dp.idProducto, p.nombre AS nombre_producto, SUM(dp.cantidad) AS total_vendido FROM detalleventa dp INNER JOIN producto p ON dp.idProducto = p.idProducto INNER JOIN venta vt ON dp.idVenta = vt.idVenta WHERE YEAR(vt.fechaHoraVenta)= YEAR(CURDATE()) AND vt.estado=1 GROUP BY dp.idProducto, p.nombre ORDER BY total_vendido DESC LIMIT 1;");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int idProducto = rs.getInt("idProducto");
                String nombreProducto = rs.getString("nombre_producto");
                int totalVenta = rs.getInt("total_vendido");
                productoVendido = new DetalleVenta(idProducto, nombreProducto, totalVenta);
            }
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }

        return productoVendido;
    }

    public int obtenerCantidadClientesRegistrados() {
        int clientes = 0;

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(idCliente) FROM cliente WHERE idCliente <> 1");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                clientes = rs.getInt(1);
            }
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }

        return clientes;
    }

    public double obtenerIngresoVentas() {
        double totalIngreso = 0;

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT SUM(total) as total_ingreso FROM venta WHERE YEAR(fechaHoraVenta) = YEAR(CURRENT_DATE) AND estado = 1;");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalIngreso = rs.getInt("total_ingreso");
            }
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }

        return totalIngreso;

    }

    public static List<DetalleVenta> obtenerProductosMasVendidosMes() {
        List<DetalleVenta> listaProductos = new ArrayList<DetalleVenta>();

        try {
            Connection con = getConnection();
            PreparedStatement stmtConfig = con.prepareStatement("SET lc_time_names = 'es_ES'");
            stmtConfig.execute();
            stmtConfig.close();

            PreparedStatement ps = con.prepareStatement("SELECT dp.idProducto, p.codigo, p.nombre AS nombre_producto, SUM(dp.cantidad) AS total_vendido, CONCAT(UCASE(LEFT(MONTHNAME(CURDATE()), 1)), LOWER(RIGHT(MONTHNAME(CURDATE()), LENGTH(MONTHNAME(CURDATE())) - 1))) AS mes_actual FROM detalleventa dp INNER JOIN producto p ON dp.idProducto = p.idProducto INNER JOIN venta vt ON dp.idVenta = vt.idVenta WHERE MONTH(vt.fechaHoraVenta)= MONTH(CURDATE()) AND vt.estado=1 GROUP BY dp.idProducto, p.nombre ORDER BY total_vendido DESC, p.nombre DESC LIMIT 3;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetalleVenta dev = new DetalleVenta();
                dev.setIdProducto(rs.getInt("idProducto"));
                dev.setCodigo(rs.getString("codigo"));
                dev.setNombreProducto(rs.getString("nombre_producto"));
                dev.setCantidadVendida(rs.getInt("total_vendido"));
                dev.setNombreMesActual(rs.getString("mes_actual"));
                listaProductos.add(dev);
            }
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaProductos;
    }

    public static List<Venta> obtenerClienteVentasMes() {
        List<Venta> listaClientes = new ArrayList<Venta>();

        try {
            Connection con = getConnection();
            PreparedStatement stmtConfig = con.prepareStatement("SET lc_time_names = 'es_ES'");
            stmtConfig.execute();
            stmtConfig.close();

            PreparedStatement ps = con.prepareStatement("SELECT vt.idCliente, cli.documento, CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_cliente, COUNT(vt.idCliente) AS total_ventas, CONCAT(UCASE(LEFT(MONTHNAME(CURDATE()), 1)), LOWER(RIGHT(MONTHNAME(CURDATE()), LENGTH(MONTHNAME(CURDATE())) - 1))) AS mes_actual FROM venta vt INNER JOIN cliente cli ON vt.idCliente = cli.idCliente WHERE MONTH(vt.fechaHoraVenta)= MONTH(CURDATE()) AND vt.estado=1 NOT IN (cli.idCliente = 1) GROUP BY vt.idCliente, cli.nombre ORDER BY total_ventas DESC, cli.nombre ASC LIMIT 3;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta vt = new Venta();
                vt.setIdCliente(rs.getInt("idCliente"));
                vt.setDocumento(rs.getString("documento"));
                vt.setNombreCliente(rs.getString("nombre_cliente"));
                vt.setCantidadVentas(rs.getInt("total_ventas"));
                vt.setNombreMesActual(rs.getString("mes_actual"));
                listaClientes.add(vt);
            }
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaClientes;
    }

}
