/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */

import jakarta.servlet.ServletException;
import java.io.IOException;
import model.Cliente;
import model.Producto;
import model.DetalleVenta;
import model.Venta;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 *
 * @author daniel
 */
public class reportesTest {

    private static DetalleVenta dev;
    private static DetalleVenta dev1;
    private static DetalleVenta dev2;
    private static DetalleVenta dev3;
    private static Cliente cli;
    private static Venta vt;
    private static Venta vt1;
    private static Venta vt2;
    private static Venta vt3;

    @BeforeAll
    public static void productoMasVendido() {
        dev = new DetalleVenta();
        dev.setIdProducto(1);
        dev.setNombre("Pollo a la brasa");
        dev.setTotalVenta(10);
        
        System.out.println("@BeforeAll --> Creación del Producto más vendido");
    }
    
    @BeforeAll
    public static void clientesRegistrados() {
        cli = new Cliente();
        cli.setClientesRegistrados(20);
        
        System.out.println("@BeforeAll --> Creación de la cantidad de clientes registrados");
    }
    
    @BeforeAll
    public static void ingresoAnualVentas() {
        vt = new Venta();
        vt.setIngresoAnual(4579.90);
        
        System.out.println("@BeforeAll --> Creación del ingreso anual de ventas");
    }
    
    @BeforeAll
    public static void productosMasVendidosDelMes() {
        dev1 = new DetalleVenta();
        dev1.setIdProducto(1);
        dev1.setCodigo("P0001");
        dev1.setNombre("Pollo a la brasa");
        dev1.setCantidadVendida(10);
        dev1.setNombreMesActual("Agosto");
        
        dev2 = new DetalleVenta();
        dev2.setIdProducto(2);
        dev2.setCodigo("P0002");
        dev2.setNombre("Combo Pollo con Papas");
        dev2.setCantidadVendida(8);
        dev2.setNombreMesActual("Agosto");
        
        dev3 = new DetalleVenta();
        dev3.setIdProducto(3);
        dev3.setCodigo("P0003");
        dev3.setNombre("Sopa de Pollo");
        dev3.setCantidadVendida(5);
        dev3.setNombreMesActual("Agosto");
        
        System.out.println("@BeforeAll --> Creación de los 3 productos más vendidos");
    }
    
    @BeforeAll
    public static void clientesVentasMes() {
        vt1 = new Venta();
        vt1.setIdCliente(1);
        vt1.setDocumento("75261486");
        vt1.setNombreCliente("Belen Jimenez");
        vt1.setCantidadVentas(15);
        vt1.setNombreMesActual("Agosto");
        
        vt2 = new Venta();
        vt2.setIdCliente(2);
        vt2.setDocumento("02594856");
        vt2.setNombreCliente("Jose Torres");
        vt2.setCantidadVentas(12);
        vt2.setNombreMesActual("Agosto");
        
        vt3 = new Venta();
        vt3.setIdCliente(3);
        vt3.setDocumento("28403895");
        vt3.setNombreCliente("Ivana Rojas");
        vt3.setCantidadVentas(10);
        vt3.setNombreMesActual("Agosto");
        
        System.out.println("@BeforeAll --> Creación de los 3 clientes con más ventas");
    }
    
    @Test
    public void testObtenerProductoMasVendido() throws ServletException, IOException {

        Assertions.assertEquals(1, dev.getIdProducto(), "Id debe ser: 1");
        Assertions.assertEquals("Pollo a la brasa", dev.getNombre(), "Nombre debe ser: Pollo a la brasa");
        Assertions.assertEquals(10, dev.getTotalVenta(), "La cantidad debe ser: 10");
        
        System.out.println("@Test --> Obtener producto más vendido");
    }
    
    @Test
    public void testObtenerCantidadClientesRegistrados() throws ServletException, IOException {

        Assertions.assertEquals(20, cli.getClientesRegistrados(), "Cantidad de clientes debe ser: 20");
        
        System.out.println("@Test --> Obtener cantidad de clientes registrados");
    }
    
    @Test
    public void testObtenerIngresoVentas() throws ServletException, IOException {

        Assertions.assertEquals(4579.90, vt.getIngresoAnual(), "Ingreso anual debe ser: 4579.90");
        
        System.out.println("@Test --> Obtener ingreso anual de ventas");
    }
    
    @Test
    public void testObtenerProductosMasVendidosMes() throws ServletException, IOException {
        Assertions.assertEquals(1, dev1.getIdProducto(), "Id debe ser: 1");
        Assertions.assertEquals("P0001", dev1.getCodigo(), "Código debe ser: P0001");
        Assertions.assertEquals("Pollo a la brasa", dev1.getNombre(), "Nombre debe ser: Pollo a la brasa");
        Assertions.assertEquals(10, dev1.getCantidadVendida(), "Cantidad debe ser: 10");
        Assertions.assertEquals("Agosto", dev1.getNombreMesActual(), "Mes debe ser: Agosto");
        
        Assertions.assertEquals(2, dev2.getIdProducto(), "Id debe ser: 2");
        Assertions.assertEquals("P0002", dev2.getCodigo(), "Código debe ser: P0002");
        Assertions.assertEquals("Combo Pollo con Papas", dev2.getNombre(), "Nombre debe ser: Combo Pollo con Papas");
        Assertions.assertEquals(8, dev2.getCantidadVendida(), "Cantidad debe ser: 8");
        Assertions.assertEquals("Agosto", dev2.getNombreMesActual(), "Mes debe ser: Agosto");
        
        Assertions.assertEquals(3, dev3.getIdProducto(), "Id debe ser: 3");
        Assertions.assertEquals("P0003", dev3.getCodigo(), "Código debe ser: P0003");
        Assertions.assertEquals("Sopa de Pollo", dev3.getNombre(), "Nombre debe ser: Sopa de Pollo");
        Assertions.assertEquals(5, dev3.getCantidadVendida(), "Cantidad debe ser: 5");
        Assertions.assertEquals("Agosto", dev3.getNombreMesActual(), "Mes debe ser: Agosto");
        
        System.out.println("@Test --> Obtener productos más vendidos del mes");
    }
    
    @Test
    public void testObtenerClienteVentasMes() throws ServletException, IOException {
        Assertions.assertEquals(1, vt1.getIdCliente(), "Id debe ser: 1");
        Assertions.assertEquals("75261486", vt1.getDocumento(), "Código debe ser: 75261486");
        Assertions.assertEquals("Belen Jimenez", vt1.getNombreCliente(), "Nombre debe ser: Belen Jimenez");
        Assertions.assertEquals(15, vt1.getCantidadVentas(), "Cantidad debe ser: 15");
        Assertions.assertEquals("Agosto", vt1.getNombreMesActual(), "Mes debe ser: Agosto");
        
        Assertions.assertEquals(2, vt2.getIdCliente(), "Id debe ser: 2");
        Assertions.assertEquals("02594856", vt2.getDocumento(), "Código debe ser: 02594856");
        Assertions.assertEquals("Jose Torres", vt2.getNombreCliente(), "Nombre debe ser: Jose Torres");
        Assertions.assertEquals(12, vt2.getCantidadVentas(), "Cantidad debe ser: 12");
        Assertions.assertEquals("Agosto", vt2.getNombreMesActual(), "Mes debe ser: Agosto");
        
        Assertions.assertEquals(3, vt3.getIdCliente(), "Id debe ser: 3");
        Assertions.assertEquals("28403895", vt3.getDocumento(), "Código debe ser: 28403895");
        Assertions.assertEquals("Ivana Rojas", vt3.getNombreCliente(), "Nombre debe ser: Ivana Rojas");
        Assertions.assertEquals(10, vt3.getCantidadVentas(), "Cantidad debe ser: 10");
        Assertions.assertEquals("Agosto", vt3.getNombreMesActual(), "Mes debe ser: Agosto");
    
        System.out.println("@Test --> Obtener clientes con más ventas del mes");
    }
}
