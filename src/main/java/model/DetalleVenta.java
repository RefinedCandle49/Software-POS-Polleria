package model;

public class DetalleVenta {
    int detalleVenta, idVenta, idProducto, cantidad;
    int totalVenta; String nombreProducto;

    public DetalleVenta(int idProducto, String nombreProducto, int totalVenta) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.totalVenta = totalVenta;
    }

    public DetalleVenta(int detalleVenta, int idVenta, int idProducto, int cantidad) {
        this.detalleVenta = detalleVenta;
        this.idVenta = idVenta;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public DetalleVenta() {
    }

    public int getDetalleVenta() {
        return detalleVenta;
    }

    public void setDetalleVenta(int detalleVenta) {
        this.detalleVenta = detalleVenta;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getTotalVenta() {
        return totalVenta;
    }

    public void setTotalVenta(int totalVenta) {
        this.totalVenta = totalVenta;
    }

}
