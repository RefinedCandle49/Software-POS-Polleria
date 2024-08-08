import jakarta.servlet.ServletException;
import model.Cliente;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.rmi.ServerException;

public class clienteTest {

    private static Cliente cli;

    @BeforeAll
    public static void Inicio(){
        cli = new Cliente();
        cli.setIdCliente(1);
        cli.setEstado(1);
        System.out.println("@BeforeAll --> Creacion de cliente");
    }
    @Test
    public void testIdCliente() throws ServerException, IOException{
        boolean idCliMin = false;
        if (cli.getIdCliente() > 0){
            idCliMin = true;

        }
        Assertions.assertEquals(true,idCliMin,"IdCliente dede ser : Mayor a 0");
        System.out.println("@Test --> Validar IdCliente");
    }
    @Test
    public void testEstado() throws ServletException, IOException {
        boolean estadoValido = cli.getEstado() == 1 || cli.getEstado() == 0;
        Assertions.assertEquals(true,estadoValido,"El estado debe ser 1 (activo) o 0  (inactivo)");
        System.out.println("@Test --> Validar Estado");
    }
    @Test
    public void testCambiarEstadoCliente() throws ServletException, IOException{
        Assertions.assertEquals(1,cli.getEstado(), "Estado inicial debe ser: 1");
        cli.setEstado(0);
        Assertions.assertEquals(0,cli.getEstado(), "Estado inicial debe ser: 0");

        cli.setEstado(1);
        Assertions.assertEquals(1,cli.getEstado(), "Estado inicial debe ser: 1");
        System.out.println("@Test --> Cambiar Estado del Cliente (Eliminar y Restaurar)");
    }
}
