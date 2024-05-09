/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ClienteDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Cliente;

/**
 *
 * @author daniel
 */
@WebServlet(name = "controlCliente", urlPatterns = {"/controlCliente"})
public class controlCliente extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet controlCliente</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet controlCliente at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action) {
            case "registrar":
                try {
                String idClienteRegistrar = request.getParameter("idCliente");
                String nombreRegistrar = request.getParameter("nombre");
                String apellidoRegistrar = request.getParameter("apellido");
                String emailRegistrar = request.getParameter("email");

                // ERRORES //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ClienteDao cliDao = new ClienteDao();
                String mensajeError = null;

                if (cliDao.validarEmail(emailRegistrar)) {
                    mensajeError = "Este correo electronico se encuentra en uso. Por favor, ingresa uno diferente.";
                }

                if (cliDao.validarId(idClienteRegistrar)) {
                    mensajeError = "Este DNI/RUC se encuentra en uso. Por favor, ingresa uno diferente.";
                }

                if (mensajeError != null) {
                    request.setAttribute("mensajeError", mensajeError);
                    response.sendRedirect(request.getContextPath() + "/caja/clientes/registrar.jsp?mensajeError=" + mensajeError);
                    return;
                }
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                Cliente cliRegistrar = new Cliente();
                cliRegistrar.setIdCliente(idClienteRegistrar);
                cliRegistrar.setNombre(nombreRegistrar);
                cliRegistrar.setApellido(apellidoRegistrar);
                cliRegistrar.setEmail(emailRegistrar);

                int resultRegistrar = ClienteDao.registrarCliente(cliRegistrar);

                if (resultRegistrar > 0) {
                    String registroExitoso = "Cliente registrado correctamente";
                    response.sendRedirect(request.getContextPath() + "/caja/clientes/cartera.jsp?registroExitoso=" + registroExitoso);
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
