package dao;

import model.Carrito;
import model.Venta;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;
import java.text.SimpleDateFormat;
import java.util.Date;

public class VentaDao {

    PreparedStatement ps;
    ResultSet rs;

    public String generarVenta(Venta venta) {
        int idVenta = 0;
        int estado = 0;
        String codigo = "";
        try {
            Connection con = getConnection();
            ps = con.prepareStatement("INSERT INTO venta (idCliente, metodoPago, fechaHoraVenta, estado, total) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, venta.getIdCliente());
            ps.setInt(2, venta.getMetodoPago());
            ps.setString(3, venta.getFechaHoraVenta());
            ps.setInt(4, 1);
            ps.setDouble(5, venta.getTotal());

            estado = ps.executeUpdate();

            String SQL = "SELECT @@IDENTITY AS idVenta";
            rs = ps.executeQuery(SQL);
            rs.next();
            idVenta = rs.getInt("idVenta");
            rs.close();

            // Generar codigo
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String fechaActual = sdf.format(new Date());

            codigo = "V-" + fechaActual + "-" + idVenta;

            ps = con.prepareStatement("UPDATE venta SET codigo =? WHERE idVenta=?");
            ps.setString(1, codigo);
            ps.setInt(2, idVenta);
            estado = ps.executeUpdate();

            /*ps = con.prepareStatement("SELECT codigo FROM venta WHERE idVenta=?");
            ps.setInt(1, idVenta);
            estado = ps.executeUpdate();
            if (rs.next()) {
                Venta vent = new Venta();
                vent.setCodigo(rs.getString("codigo"));
            }*/
            for (Carrito detalle : venta.getDetalleVenta()) {
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

        } catch (Exception e) {
            System.out.println(e);
        }
        return codigo;
    }

    public static List<Venta> listarVentas() {
        List<Venta> listaVentas = new ArrayList<Venta>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT vent.idVenta, vent.codigo, cli.nombre, cli.apellido, vent.metodoPago, vent.fechaHoraVenta, vent.estado, vent.total FROM venta vent INNER JOIN cliente cli ON vent.idCliente = cli.idCliente WHERE vent.estado=1 ORDER BY idVenta DESC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta vent = new Venta();
                vent.setIdVenta(rs.getInt("idVenta"));
                vent.setCodigo(rs.getString("codigo"));
                vent.setNombre(rs.getString("nombre"));
                vent.setApellido(rs.getString("apellido"));
                vent.setMetodoPago(rs.getInt("metodoPago"));
                vent.setFechaHoraVenta(rs.getString("fechaHoraVenta"));
                vent.setEstado(rs.getInt("estado"));
                vent.setTotal(rs.getDouble("total"));
                listaVentas.add(vent);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaVentas;
    }

    public static int anularVenta(Venta vent) {
        int est = 0;
        PreparedStatement ps = null;
        
        try {
            Connection con = getConnection();
            // Iniciar Transaccion (Todos los SQL deben ejecutarse)
            con.setAutoCommit(false);
            
            // Actualizar el estado de la venta
            ps = con.prepareStatement("UPDATE venta SET estado=? WHERE idVenta=?");
            ps.setInt(1, vent.getEstado());
            ps.setInt(2, vent.getIdVenta());
            est = ps.executeUpdate();

            // Obtener los detalles de la venta
            ps = con.prepareStatement("SELECT idProducto, cantidad FROM detalleVenta WHERE idVenta=?");
            ps.setInt(1, vent.getIdVenta());
            ResultSet rs = ps.executeQuery();
            
            // Restaurar stock
            while (rs.next()) {
                int idProducto = rs.getInt("idProducto");
                int cantidad = rs.getInt("cantidad");
                
                PreparedStatement psUpdate = con.prepareStatement("UPDATE producto SET stock = stock + ? WHERE idProducto = ?");
                psUpdate.setInt(1, cantidad);
                psUpdate.setInt(2, idProducto);
                psUpdate.executeUpdate();
            }
            
            con.commit();
            
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }

    public static List<Venta> listarVentasAnuladas() {
        List<Venta> ventasAnuladas = new ArrayList<Venta>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT vent.idVenta, vent.codigo, cli.nombre, cli.apellido, vent.metodoPago, vent.fechaHoraVenta, vent.estado, vent.total FROM venta vent INNER JOIN cliente cli ON vent.idCliente = cli.idCliente WHERE vent.estado=0 ORDER BY idVenta DESC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Venta vent = new Venta();
                vent.setIdVenta(rs.getInt("idVenta"));
                vent.setCodigo(rs.getString("codigo"));
                vent.setNombre(rs.getString("nombre"));
                vent.setApellido(rs.getString("apellido"));
                vent.setMetodoPago(rs.getInt("metodoPago"));
                vent.setFechaHoraVenta(rs.getString("fechaHoraVenta"));
                vent.setEstado(rs.getInt("estado"));
                vent.setTotal(rs.getDouble("total"));
                ventasAnuladas.add(vent);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return ventasAnuladas;
    }

    public static Venta obtenerVentaPorId(int idVenta) {
        Venta venta = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT vent.idVenta, vent.idCliente, cli.documento, cli.nombre, cli.apellido, vent.metodoPago, vent.fechaHoraVenta, vent.estado, vent.total FROM venta vent INNER JOIN cliente cli ON vent.idCliente = cli.idCliente WHERE idVenta=?");
            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                venta = new Venta();
                venta.setIdVenta(rs.getInt("idVenta"));
                venta.setIdCliente(rs.getInt("idCliente"));
                venta.setDocumento(rs.getString("documento"));
                venta.setNombre(rs.getString("nombre"));
                venta.setApellido(rs.getString("apellido"));
                venta.setMetodoPago(rs.getInt("metodoPago"));
                venta.setFechaHoraVenta(rs.getString("fechaHoraVenta"));
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
