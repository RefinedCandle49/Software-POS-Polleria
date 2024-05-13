package model;

import java.util.List;

public class Venta {

    public Venta(String idCliente, int metodoPago, String FechaHoraActual, int estado, double total, List<Carrito> detalleVenta) {
        this.idCliente = idCliente;
        this.metodoPago = metodoPago;
        this.FechaHoraActual = FechaHoraActual;
        this.estado = estado;
        this.total = total;
        this.detalleVenta = detalleVenta;
    }

    String nombre;
    String apellido;

    public String getHoraVenta() {
        return horaVenta;
    }

    public void setHoraVenta(String horaVenta) {
        this.horaVenta = horaVenta;
    }

    String horaVenta;

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

    String FechaHoraActual;

    public String getFechaHoraActual() {
        return FechaHoraActual;
    }

    public void setFechaHoraActual(String fechaHoraActual) {
        FechaHoraActual = fechaHoraActual;
    }
}
