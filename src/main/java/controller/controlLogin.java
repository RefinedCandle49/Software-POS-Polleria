/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Usuario;

/**
 *
 * @author daniel
 */
@WebServlet(name = "controlLogin", urlPatterns = {"/controlLogin"})
public class controlLogin extends HttpServlet {

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

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mensajeError = null;

        UsuarioDao daoUsuario = new UsuarioDao();
        Usuario usuario = new Usuario();
        usuario.setEmail(email);
        usuario.setPassword(password);

        if (daoUsuario.validarUsuario(usuario)) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            String rol = usuario.getRol();
            if ("Administrador".equals(rol)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp?alert=true");
            } else if ("Cajero".equals(rol)) {
                response.sendRedirect(request.getContextPath() + "/caja/menu.jsp?alert=true");
            } else if ("Almacenero".equals(rol)) {
                response.sendRedirect(request.getContextPath() + "/almacen/productos.jsp?alert=true&page=1");
            }
            return;

        } else if (daoUsuario.validarUsuarioInactivo(usuario)) {
            mensajeError = "Esta usuario no tiene acceso al sistema.";
            
            if (mensajeError != null) {
                request.setAttribute("mensajeError", mensajeError);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
            /*response.sendRedirect(request.getContextPath() + "/index.jsp?mensajeError=" + mensajeError);*/
            return;
            
        } else {
            mensajeError = "Parece que has ingresado credenciales incorrectas. Por favor, intenta de nuevo.";

            if (mensajeError != null) {
                request.setAttribute("mensajeError", mensajeError);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

            /*response.sendRedirect(request.getContextPath() + "/index.jsp?mensajeError=" + mensajeError);*/
        }
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
        processRequest(request, response);
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
