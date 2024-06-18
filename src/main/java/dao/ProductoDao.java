package dao;

import model.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class ProductoDao {

    public static List<Producto> listarPollos() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, foto, precio, stock FROM producto WHERE estado = 1 AND idCategoria = ? AND stock > 0");
            ps.setInt(1, 1);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                list.add(prod);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static List<Producto> listarSopas() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, foto, precio, stock FROM producto WHERE estado = 1 AND idCategoria = ? AND stock > 0");
            ps.setInt(1, 2);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                list.add(prod);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static List<Producto> listarBebidas() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, foto, precio, stock FROM producto WHERE estado = 1 AND idCategoria = ? AND stock > 0");
            ps.setInt(1, 3);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                list.add(prod);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static List<Producto> listarPostres() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, foto, precio, stock FROM producto WHERE estado = 1 AND idCategoria = ? AND stock > 0");
            ps.setInt(1, 4);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                list.add(prod);
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Producto listarId(int id) {
        Producto p = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, idCategoria, nombre, descripcion, foto, precio, stock FROM producto WHERE idProducto = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                p = new Producto();
                p.setIdProducto(rs.getInt("idProducto"));
                p.setIdCategoria(rs.getInt("idCategoria"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setFoto(rs.getString("foto"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (Exception e) {

        }
        return p;
    }

    public static int contarProductos(){
        int totalProductos = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS total FROM producto WHERE estado=1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalProductos = rs.getInt("total");
            }
            con.close();

        } catch (Exception e){

        }
        return totalProductos;
    }

    public static int registrarProducto(Producto prod) {
        int idProducto = 0;
        try {
            Connection con = getConnection();
            String query = "INSERT INTO producto(idCategoria, nombre, descripcion, foto, precio, stock, estado) VALUES (?, ?, ?,?,?,?,?) ";
            PreparedStatement ps = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, prod.getIdCategoria());
            ps.setString(2, prod.getNombre());
            ps.setString(3, prod.getDescripcion());
            ps.setString(4, prod.getFoto());
            ps.setDouble(5, prod.getPrecio());
            ps.setInt(6, prod.getStock());
            ps.setInt(7, prod.getEstado());
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idProducto = rs.getInt(1);
                
                String codigo = "P" + String.format("%04d", idProducto);
                
                ps = con.prepareStatement("UPDATE producto SET codigo=? WHERE idProducto=?");
                ps.setString(1, codigo);
                ps.setInt(2, idProducto);
                ps.executeUpdate();
            }
            
        } catch (Exception e) {
            System.out.println(e);
        }
        return idProducto;
    }

    public static List<Producto> listarProductos() {
        List<Producto> listaProductos = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT prod.idProducto, cat.nombre as nombreCategoria, prod.codigo ,prod.nombre, prod.descripcion, prod.foto, prod.precio, prod.stock, prod.estado FROM producto prod INNER JOIN categoria cat ON prod.idCategoria = cat.idCategoria WHERE prod.estado = 1 ORDER BY idProducto DESC");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
                prod.setCodigo(rs.getString("codigo"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                prod.setEstado(rs.getInt("estado"));
                listaProductos.add(prod);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaProductos;
    }

    public static List<Producto> listarProductosPagina(int start, int total) {
        List<Producto> listaProductos = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT prod.idProducto, cat.nombre as nombreCategoria, prod.codigo ,prod.nombre, prod.descripcion, prod.foto, prod.precio, prod.stock, prod.estado FROM producto prod INNER JOIN categoria cat ON prod.idCategoria = cat.idCategoria WHERE prod.estado = 1 ORDER BY idProducto DESC LIMIT ?, ?");
            ps.setInt(1, start-1);
            ps.setInt(2, total);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
                prod.setCodigo(rs.getString("codigo"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setFoto(rs.getString("foto"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                prod.setEstado(rs.getInt("estado"));
                listaProductos.add(prod);
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaProductos;
    }

    public boolean validarProducto(String producto) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM producto WHERE nombre = ?");
            ps.setString(1, producto);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {

        }
        return false;
    }
    
     public static Producto obtenerProductoPorId(int idProducto) {
        Producto producto = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, idCategoria, codigo, nombre, descripcion, foto, precio, stock, estado FROM producto WHERE idProducto=?");
            ps.setInt(1, idProducto);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setCodigo(rs.getString("codigo"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setFoto(rs.getString("foto"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return producto;
    }
 public static int actualizarProducto(Producto prod) {
        int estado = 0;
        try {
            
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE producto SET idCategoria=?, nombre=?, descripcion=?,foto =?, precio=?, stock=? WHERE idProducto=?;");
            ps.setInt(1, prod.getIdCategoria());
            ps.setString(2, prod.getNombre());
            ps.setString(3, prod.getDescripcion());
            ps.setString(4, prod.getFoto());
            ps.setDouble(5, prod.getPrecio());
            ps.setInt(6, prod.getStock());
            ps.setInt(7, prod.getIdProducto());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

        return estado;
    }
  
  
  public boolean validarNombreExcepto(String nombre, int idProducto) {
        try{
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM producto WHERE nombre=? AND idProducto !=?");
            ps.setString(1, nombre);
            ps.setInt(2, idProducto);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
   
}
