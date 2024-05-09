package dao;

import model.Carrito;
import model.Venta;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class VentaDao {

    PreparedStatement ps;
    ResultSet rs;

    public static String obtenerFechaActual() {
        java.util.Date fecha = new java.util.Date();
        java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
        return formato.format(fecha);
    }
    public int generarVenta(Venta venta){
        int idVenta;
        int estado = 0;
        try {
            Connection con = getConnection();
            ps = con.prepareStatement("INSERT INTO venta (idCliente, metodoPago, horaVenta, estado, total) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, venta.getIdCliente());
            ps.setInt(2, venta.getMetodoPago());
            ps.setString(3, obtenerFechaActual());
            ps.setInt(4, 0);
            ps.setDouble(5, venta.getTotal());

            estado = ps.executeUpdate();

            String SQL = "SELECT @@IDENTITY AS idVenta";
            rs = ps.executeQuery(SQL);
            rs.next();
            idVenta = rs.getInt("idVenta");
            rs.close();

            for (Carrito detalle : venta.getDetalleVenta()){
                SQL = "INSERT INTO detalleventa (idVenta, idProducto, cantidad, subtotal) VALUES (?, ?, ?, ?)";
                ps = con.prepareStatement(SQL);
                ps.setInt(1, idVenta);
                ps.setInt(2, detalle.getIdProducto());
                ps.setInt(3, detalle.getCantidad());
                ps.setDouble(4, detalle.getSubtotal());

                estado = ps.executeUpdate();
                rs.close();

                String UPDATE = "UPDATE producto SET stock = stock -? WHERE idProducto =?";
                ps = con.prepareStatement(UPDATE);
                ps.setInt(1, detalle.getCantidad());
                ps.setInt(2, detalle.getIdProducto());
                estado = ps.executeUpdate();
            }


        } catch (Exception e){
            System.out.println(e);
        }
        return estado;
    }

    public static List<Venta> listarVentas() {
        List<Venta> listaVentas = new ArrayList<Venta>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT vent.idVenta, cli.nombre, cli.apellido, vent.metodoPago, vent.horaVenta, vent.estado, vent.total FROM venta vent INNER JOIN cliente cli ON vent.idCliente = cli.idCliente WHERE estado=0 OR estado=1 ORDER BY idVenta DESC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta vent = new Venta();
                vent.setIdVenta(rs.getInt("idVenta"));
                vent.setNombre(rs.getString("nombre"));
                vent.setApellido(rs.getString("apellido"));
                vent.setMetodoPago(rs.getInt("metodoPago"));
                vent.setHoraVenta(rs.getString("horaVenta"));
                vent.setEstado(rs.getInt("estado"));
                vent.setTotal(rs.getDouble("total"));
                listaVentas.add(vent);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaVentas;
    }

    public static Venta obtenerVentaPorId(int idVenta) {
        Venta venta = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT vent.idVenta, cli.nombre, cli.apellido, vent.metodoPago, vent.horaVenta, vent.estado, vent.total FROM venta vent INNER JOIN cliente cli ON vent.idCliente = cli.idCliente WHERE idVenta=?");
            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                venta = new Venta();
                venta.setIdVenta(rs.getInt("idVenta"));
                venta.setNombre(rs.getString("nombre"));
                venta.setApellido(rs.getString("apellido"));
                venta.setMetodoPago(rs.getInt("metodoPago"));
                venta.setHoraVenta(rs.getString("horaVenta"));
                venta.setEstado(rs.getInt("estado"));
                venta.setTotal(rs.getDouble("total"));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return venta;
    }

//    public static List<Venta> listarEntregas() {
//        List<Venta> listaEntregas = new ArrayList<Venta>();
//        try {
//            Connection con = getConnection();
//            PreparedStatement ps = con.prepareStatement(
//                    "SELECT idVenta, horaVenta, estado FROM venta WHERE estado=1 ORDER BY idVenta ASC;");
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Venta ent = new Venta();
//                ent.setIdVenta(rs.getInt("idVenta"));
//                ent.setHoraVenta(rs.getString("horaVenta"));
//                ent.setEstado(rs.getInt("estado"));
//                listaEntregas.add(ent);
//            }
//
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//
//        return listaEntregas;
//    }
}
