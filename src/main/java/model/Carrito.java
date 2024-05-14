package model;

public class Carrito {

    int idProducto;

    public int getItem() {
        return item;
    }

    public void setItem(int item) {
        this.item = item;
    }

    int item, cantidad;


    double precio;

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public Carrito(int idProducto, int item, int cantidad, double precio, double subtotal, String nombre) {
        this.idProducto = idProducto;
        this.item = item;
        this.cantidad = cantidad;
        this.precio = precio;
        this.subtotal = subtotal;
        this.nombre = nombre;
    }

    int stock;

    double subtotal;
    String nombre;

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Carrito() {
    }
}
