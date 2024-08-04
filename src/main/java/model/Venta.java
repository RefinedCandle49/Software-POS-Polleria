package model;

import java.util.List;

public class Venta {

    private int mes;
    private int ventas;

    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    public int getVentas() {
        return ventas;
    }

    public void setVentas(int ventas) {
        this.ventas = ventas;
    }

    public Venta(int idCliente, String fechaHoraVenta, int estado, double total, List<Carrito> detalleVenta) {
        this.idCliente = idCliente;
        this.fechaHoraVenta = fechaHoraVenta;
        this.estado = estado;
        this.total = total;
        this.detalleVenta = detalleVenta;
    }
    
    String codigo;
    String documento;
    String nombre;
    String apellido;
    
    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
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
    int idCliente;
    int estado;
    double total;

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
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
    
    int cantidadVentas;
    String nombreCliente, nombreMesActual;

    public int getCantidadVentas() {
        return cantidadVentas;
    }

    public void setCantidadVentas(int cantidadVentas) {
        this.cantidadVentas = cantidadVentas;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getNombreMesActual() {
        return nombreMesActual;
    }

    public void setNombreMesActual(String nombreMesActual) {
        this.nombreMesActual = nombreMesActual;
    }
    
}
