
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
        usu.setCodigo("U0001");
        usu.setEmail("administrador@polloslocos.com");
        usu.setPassword("administrador123");
        usu.setRol("Administrador");
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
    public void testCodigo() throws ServletException, IOException {
    
        boolean codigoMin = false;
        boolean codigoMax = false;
        
        if (usu.getCodigo().length() > 0) {
            codigoMin = true;
        }
        
        if (usu.getCodigo().length() <= 5) {
            codigoMax = true;
        }
        
        Assertions.assertEquals(true, codigoMin, "Longitud de nombre: Mayor a 0");
        Assertions.assertEquals(true, codigoMax, "Longitud de nombre: Menor o igual a 5");
        
        System.out.println("@Test --> Validar Codigo");
    }
    
    @Test
    public void testEmail() throws ServletException, IOException {
        boolean emailValido = usu.getEmail().contains("@polloslocos.com");
        Assertions.assertEquals(true, emailValido, "El email debe contener '@polloslocos.com'");
        System.out.println("@Test --> Validar Email");
    }
    
    @Test
    public void testRol() throws ServletException, IOException {
        boolean rolValido = usu.getRol().equals("Administrador") || usu.getRol().equals("Usuario");
        Assertions.assertEquals(true, rolValido, "El rol debe ser 'Administrador' o 'Usuario'");
        System.out.println("@Test --> Validar Rol");
    }
    
    @Test
    public void testEstado() throws ServletException, IOException {
        boolean estadoValido = usu.getEstado() == 1 || usu.getEstado() == 0;
        Assertions.assertEquals(true, estadoValido, "El estado debe ser 1 (activo) o 0 (inactivo)");
        System.out.println("@Test --> Validar Estado");
    }
    
    @Test
    public void testActualizarUsuario() throws ServletException, IOException {
        Assertions.assertEquals(1, usu.getIdUsuario(), "Id debe ser: 1");
        Assertions.assertEquals("U0001", usu.getCodigo(), "Código debe ser: U0001");
        Assertions.assertEquals("administrador@polloslocos.com", usu.getEmail(), "Email debe ser: administrador@polloslocos.com");
        Assertions.assertEquals("administrador123", usu.getPassword(), "Password debe ser: administrador123");
        Assertions.assertEquals("Administrador", usu.getRol(), "Rol debe ser: Administrador");
        Assertions.assertEquals(1, usu.getEstado(), "Estado debe ser: 1");

        usu.setPassword("admin123");
        usu.setRol("Cajero");

        Assertions.assertEquals("admin123", usu.getPassword(), "Password debe ser: admin123");
        Assertions.assertEquals("Cajero", usu.getRol(), "Rol debe ser: Cajero");

        System.out.println("@Test --> Actualizar Contraseña y Rol del Usuario");
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
