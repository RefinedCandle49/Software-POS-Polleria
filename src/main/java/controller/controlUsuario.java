package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import dao.UsuarioDao;
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
                    mensajeError = "¡Oh no! Este correo electrónico ya está en uso. Por favor, ingresa uno diferente.";
                }

                if (mensajeError != null) {
                    request.setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("/admin/registrar.jsp").forward(request, response);
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
                    response.sendRedirect(request.getContextPath() + "/admin/usuarios.jsp");
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
