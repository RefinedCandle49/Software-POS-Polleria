package model;

import java.util.List;

public class Venta {

    public Venta(String idCliente, int metodoPago, String fechaHoraVenta, int estado, double total, List<Carrito> detalleVenta) {
        this.idCliente = idCliente;
        this.metodoPago = metodoPago;
        this.fechaHoraVenta = fechaHoraVenta;
        this.estado = estado;
        this.total = total;
        this.detalleVenta = detalleVenta;
    }
    
    String codigo;
    String nombre;
    String apellido;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public Venta() {
    }

    int idVenta;
    String idCliente;
    int metodoPago, estado;
    double total;

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public List<Carrito> getDetalleVenta() {
        return detalleVenta;
    }

    public void setDetalleVenta(List<Carrito> detalleVenta) {
        this.detalleVenta = detalleVenta;
    }

    List<Carrito> detalleVenta;

    public String getFechaHoraVenta() {
        return fechaHoraVenta;
    }

    public void setFechaHoraVenta(String fechaHoraVenta) {
        this.fechaHoraVenta = fechaHoraVenta;
    }

    String fechaHoraVenta;
}
