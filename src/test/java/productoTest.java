import jakarta.servlet.ServletException;
import model.Producto;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.rmi.ServerException;

public class productoTest {
    
    private static Producto prod;
    
    @BeforeAll
    public static void Inicio(){
        prod = new Producto();
        prod.setIdProducto(1);
        prod.setEstado(1);
        System.out.print("@BeforeAll --> Creacion de producto");
    }
    @Test
    public void testIdProducto() throws ServerException,IOException{
        boolean idProdMin = false;
        if (prod.getIdProducto() > 0){
            idProdMin = true;  
        }
        Assertions.assertEquals(true,idProdMin,"IdProducto debe ser mayor a 0");
        System.out.println("@Test --> Validar IdProducto");
    }
    @Test
    public void testEstado() throws ServerException,IOException{
        boolean estadoValido = prod.getEstado() == 1 || prod.getEstado() == 0;
        Assertions.assertEquals(true,estadoValido,"El estado debe ser 1 (activo) o 0 (inactivo)");
        System.out.println("@Test --> Validar Estado");
    }
    @Test
    public void testCambiarEstadoProducto() throws ServletException,IOException {
        Assertions.assertEquals(1,prod.getEstado(), "Estado inicial debe ser 1");
        prod.setEstado(0);
        Assertions.assertEquals(0,prod.getEstado(), "Estado debe ser 0");
        
        prod.setEstado(1);
        Assertions.assertEquals(1,prod.getEstado(), "Estado debe ser 1");
        System.out.println("@Test --> Cambiar Estado del Producto (Desactivar y Activar)");
    }
    
}

