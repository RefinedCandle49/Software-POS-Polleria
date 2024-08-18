
import jakarta.servlet.ServletException;
import java.io.IOException;
import model.Usuario;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class usuarioTest {
    
    private static Usuario usu;
    
    @BeforeAll
    public static void Inicio() {
        usu = new Usuario();
        usu.setIdUsuario(1);
        usu.setEstado(1);
        
        System.out.println("@BeforeAll --> Creación del Usuario");
    }
    
    @Test
    public void testIdUsuario() throws ServletException, IOException {
        
        boolean idUsuMin = false;
        
        if (usu.getIdUsuario() > 0 ) {
            idUsuMin = true;
        }
        
        Assertions.assertEquals(true, idUsuMin, "IdUsuario debe ser: Mayor a 0");
        
        System.out.println("@Test --> Validar IdUsuario");
    }
    
    @Test
    public void testEstado() throws ServletException, IOException {
        boolean estadoValido = usu.getEstado() == 1 || usu.getEstado() == 0;
        
        Assertions.assertEquals(true, estadoValido, "El estado debe ser 1 (activo) o 0 (inactivo)");
        
        System.out.println("@Test --> Validar Estado");
    }

    @Test
    public void testCambiarEstadoUsuario() throws ServletException, IOException {
        Assertions.assertEquals(1, usu.getEstado(), "Estado inicial debe ser: 1");

        usu.setEstado(0);
        Assertions.assertEquals(0, usu.getEstado(), "Estado debe ser: 0");

        usu.setEstado(1);
        Assertions.assertEquals(1, usu.getEstado(), "Estado debe ser: 1");

        System.out.println("@Test --> Cambiar Estado del Usuario (Eliminar y Restaurar)");
    }

}
