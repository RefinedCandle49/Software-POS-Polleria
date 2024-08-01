package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import dao.UsuarioDao;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import model.Usuario;

/**
 *
 * @author user
 */
@WebServlet(name = "controlUsuario", urlPatterns = {"/controlUsuario"})
public class controlUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        String action = request.getParameter("action");

        switch (action) {
            case "editar":
                int idUsuario = Integer.parseInt(request.getParameter("id"));
                Usuario usuario = UsuarioDao.obtenerUsuarioPorId(idUsuario);
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/admin/usuario/actualizar.jsp").forward(request, response);
                return; }
    }

    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action) {
            case "registrar":
                try {
                String emailRegistrar = request.getParameter("email");
                String passwordRegistrar = request.getParameter("password");
                String rolRegistrar = request.getParameter("rol");
                int estadoRegistrar = Integer.parseInt(request.getParameter("estado"));

                // ERRORES //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                UsuarioDao userDao = new UsuarioDao();
                String mensajeError = null;

                if (userDao.validarEmail(emailRegistrar)) {
                    mensajeError = "Este correo electrónico se encuentra en uso. Por favor, ingresa uno diferente.";
                }

                if (mensajeError != null) {
                    request.setAttribute("mensajeError", mensajeError);
                    request.setAttribute("email", emailRegistrar);
                    request.setAttribute("password", passwordRegistrar);
                    request.setAttribute("rol", rolRegistrar);
                    request.setAttribute("estado", estadoRegistrar);
                    request.getRequestDispatcher("admin/usuario/registrar.jsp").forward(request, response);
                    //response.sendRedirect(request.getContextPath() + "/admin/registrar.jsp?mensajeError=" + mensajeError);
                    return;
                }
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                Usuario userRegistrar = new Usuario();
                userRegistrar.setEmail(emailRegistrar);
                userRegistrar.setPassword(passwordRegistrar);
                userRegistrar.setRol(rolRegistrar);
                userRegistrar.setEstado(estadoRegistrar);

                int resultRegistrar = UsuarioDao.registrarUsuario(userRegistrar);

                if (resultRegistrar > 0) {    
                    String registroExitoso = "Usuario registrado correctamente";
                    response.sendRedirect(request.getContextPath() + "/admin/usuarios.jsp?registroExitoso=" + registroExitoso + "&page=1");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;

            case "actualizar":
                try {
                    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                    //String codigo = request.getParameter("codigo");
                    //String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String rol = request.getParameter("rol");
                    //int estado = Integer.parseInt(request.getParameter("estado"));
                    System.out.println("Obtener Parametros");
                    
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(idUsuario);
                    //usuario.setCodigo(codigo);
                    //usuario.setEmail(email);
                    usuario.setPassword(password);
                    usuario.setRol(rol);
                    //usuario.setEstado(estado);
                    System.out.println("Dar Parametros");
                    
                    int result = UsuarioDao.actualizarUsuario(usuario);
                    
                    if (result > 0) {
                        String actualizarExitoso ="Usuario actualizado correctamente";
                        response.sendRedirect(request.getContextPath() + "/admin/usuarios.jsp?actualizarExitoso=" + actualizarExitoso + "&page=1");
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }    
            return;
            
            case "anularUsuario":
                try {
                    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                    int newEstado = Integer.parseInt(request.getParameter("newEstado"));
                     
                    Usuario usuarioAnular = new Usuario();
                    usuarioAnular.setIdUsuario(idUsuario);
                    usuarioAnular.setEstado(newEstado);
                    
                    int result = UsuarioDao.anularUsuario(usuarioAnular);
                    
                    // Mandar parametro para mostrar alerta de confirmación
                    HttpSession session = request.getSession();
                    
                    if (result > 0) {
                        response.sendRedirect(request.getContextPath() + "/admin/usuarios.jsp?anularUsuario=true&page=1");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
            case "activarUsuario":
                try {
                    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                    int newEstado = Integer.parseInt(request.getParameter("newEstado"));
                    
                    Usuario usuarioActivar = new Usuario();
                    usuarioActivar.setIdUsuario(idUsuario);
                    usuarioActivar.setEstado(newEstado);
                    
                    int result = UsuarioDao.activarUsuario(usuarioActivar);
                    
                    // Mandar parametro para mostrar alerta de confirmación
                    HttpSession session = request.getSession();
                    
                    if (result > 0 ) {
                        response.sendRedirect(request.getContextPath() + "/admin/usuario/anulados.jsp?activarUsuario=true&page=1");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return;

        }
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
