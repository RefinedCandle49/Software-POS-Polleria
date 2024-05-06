package dao;

import model.DetalleVenta;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class DetalleVentaDao {

    public static List<DetalleVenta> listarDetalleVenta(int idVenta) {
        List<DetalleVenta> listaDetalles = new ArrayList<>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT det.idDetalleVenta, det.idVenta, prod.nombre, det.cantidad FROM detalleventa det INNER JOIN producto prod ON det.idProducto = prod.idProducto WHERE idVenta=?");
            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetalleVenta det = new DetalleVenta();
                det.setDetalleVenta(rs.getInt("idDetalleVenta"));
                det.setIdVenta(rs.getInt("idVenta"));
                det.setNombre(rs.getString("nombre"));
                det.setCantidad(rs.getInt("cantidad"));
                listaDetalles.add(det);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaDetalles;
    }

    
}
