
import jakarta.servlet.ServletException;
import java.io.IOException;
import model.Producto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class controlProductoTest {

    private static Producto prod;

    @BeforeAll
    public static void Inicio() {
        prod = new Producto();
        prod.setIdProducto(1);
        prod.setIdCategoria(1);
        prod.setNombre("Pollo a la brasa");
        prod.setDescripcion("El mejor pollo");
        prod.setFoto("pollo.jpg");
        prod.setPrecio(60.00);
        prod.setStock(50);

        System.out.println("@BeforeAll --> Creación del Producto");
    }

    @Test
    public void testIdProducto() throws ServletException, IOException {
        
        boolean idProdMin = false;
        
        if (prod.getIdProducto() > 0) {
            idProdMin = true;
        }
         
        Assertions.assertEquals(true, idProdMin, "IdProducto debe ser: Mayor a 0");
        
        System.out.println("@Test --> Validar IdProducto");
    }
    
    @Test
    public void testIdCategoria() throws ServletException, IOException {
        
        boolean idCatMin = false;
        
        if (prod.getIdCategoria() > 0) {
            idCatMin = true;
        }
         
        Assertions.assertEquals(true, idCatMin, "IdCategoria debe ser: Mayor a 0");
        
        System.out.println("@Test --> Validar IdCategoria");
    }

    @Test
    public void testNombre() throws ServletException, IOException {

        boolean nombreMin = false;
        boolean nombreMax = false;

        if (prod.getNombre().length() > 0) {
            nombreMin = true;
        }

        if (prod.getNombre().length() <= 50) {
            nombreMax = true;
        }

        Assertions.assertEquals(true, nombreMin, "Longitud de nombre: Mayor a 0");
        Assertions.assertEquals(true, nombreMax, "Longitud de nombre: Menor o igual a 50");
        
        System.out.println("@Test --> Validar Nombre");
    }

    @Test
    public void testDescripcion() throws ServletException, IOException {

        boolean descripcionMin = false;
        boolean descripcionMax = false;

        if (prod.getDescripcion().length() > 0) {
            descripcionMin = true;
        }

        if (prod.getDescripcion().length() <= 200) {
            descripcionMax = true;
        }

        Assertions.assertEquals(true, descripcionMin, "Longitud de descripcion: Mayor a 0");
        Assertions.assertEquals(true, descripcionMax, "Longitud de descripcion: Menor o igual a 200");
        
        System.out.println("@Test --> Validar Descripcion");
    }

    @Test
    public void testFoto() throws ServletException, IOException {
        
        boolean imgExtension = false;
        String extension = "";
        int i = prod.getFoto().lastIndexOf('.'); // Obtener la posicion del punto en la palabra
        
        if (i > 0) {
            extension = prod.getFoto().substring(i + 1); // Extraer palabras luego del punto
        }
        
        if(extension.equals("jpg")) {
            imgExtension = true;
        }
        
        if(extension.equals("jpeg")) {
            imgExtension = true;
        }
        
        if(extension.equals("png")) {
            imgExtension = true;
        }
        
        Assertions.assertEquals(true, imgExtension, "La imagen debe ser: jpg, jpeg o png");
        
        System.out.println("@Test --> Validar Foto: " + extension);
        
    }
    
    @Test
    public void testPrecio() throws ServletException, IOException {

        boolean precioMin = false;
        boolean precioMax = false;

        if (prod.getPrecio() > 0) {
            precioMin = true;
        }

        if (prod.getPrecio() <= 999.99) {
            precioMax = true;
        }

        Assertions.assertEquals(true, precioMin, "Precio debe ser: Mayor a 0");
        Assertions.assertEquals(true, precioMax, "Precio debe ser: Menor o igual a 999.99");

        System.out.println("@Test --> Validar Precio");
    }

    @Test
    public void testStock() throws ServletException, IOException {

        boolean stockMin = false;
        boolean stockMax = false;

        if (prod.getStock() >= 0) {
            stockMin = true;
        }

        if (prod.getStock() <= 999) {
            stockMax = true;
        }

        Assertions.assertEquals(true, stockMin, "Stock debe ser: Mayor a 0");
        Assertions.assertEquals(true, stockMax, "Stock debe ser: Menor o igual a 999");

        System.out.println("@Test --> Validar Stock");
    }

    @Test
    public void testActualizarProducto() throws ServletException, IOException {

        Assertions.assertEquals(1, prod.getIdProducto(), "Id debe ser: 1");
        Assertions.assertEquals(1, prod.getIdCategoria(), "Id debe ser: 1");
        Assertions.assertEquals("Pollo a la brasa", prod.getNombre(), "Nombre debe ser: Pollo a la brasa");
        Assertions.assertEquals("El mejor pollo", prod.getDescripcion(), "Descripción debe ser: El mejor pollo");
        Assertions.assertEquals(60.00, prod.getPrecio(), "Precio debe ser: 60.00");
        Assertions.assertEquals(50, prod.getStock(), "Stock debe ser: 50");

        System.out.println("@Test --> Actualizar Producto");
    }
}