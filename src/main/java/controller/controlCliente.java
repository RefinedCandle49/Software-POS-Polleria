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
import jakarta.servlet.http.HttpSession;
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
        
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "editar":
                int idCliente = Integer.parseInt(request.getParameter("id"));
                Cliente cliente = ClienteDao.obtenerClientePorId(idCliente);
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("/caja/clientes/actualizar.jsp").forward(request, response);
                return; }
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
            case "anularCliente":
                try {
                    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                    int newEstado = Integer.parseInt(request.getParameter("newEstado"));
                     
                    Cliente cli = new Cliente();
                    cli.setIdCliente(idCliente);
                    cli.setEstado(newEstado);
                    
                    int result = ClienteDao.anularCliente(cli);
                    
                    // Mandar parametro para mostrar alerta de confirmación
                    HttpSession session = request.getSession();
                    
                    if (result > 0) {
                        response.sendRedirect(request.getContextPath() + "/caja/clientes/cartera.jsp?anularCliente=true&page=1");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return;
                
            case "registrar":
                try {
                String documentoRegistrar = request.getParameter("documento");
                String nombreRegistrar = request.getParameter("nombre");
                String apellidoRegistrar = request.getParameter("apellido");
                String emailRegistrar = request.getParameter("email");
                int estadoRegistrar = Integer.parseInt(request.getParameter("estado"));

                // ERRORES //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ClienteDao cliDao = new ClienteDao();
                StringBuilder mensajeError = new StringBuilder();

                if (cliDao.validarEmail(emailRegistrar)) {
                    mensajeError.append("<div class=\"alert alert-danger\">Este correo electrónico se encuentra en uso. Por favor, ingresa uno diferente.</div>");
                }

                if (cliDao.validarId(documentoRegistrar)) {
                    mensajeError.append("<div class=\"alert alert-danger\">Este DNI/RUC se encuentra en uso. Por favor, ingresa uno diferente.</div>");
                }

                if (mensajeError.length() > 0) {
                    request.setAttribute("mensajeError", mensajeError.toString());
                    request.setAttribute("documento", documentoRegistrar);
                    request.setAttribute("nombre", nombreRegistrar);
                    request.setAttribute("apellido", apellidoRegistrar);
                    request.setAttribute("email", emailRegistrar);
                    request.getRequestDispatcher("caja/clientes/registrar.jsp").forward(request, response);
                    return;
                }
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                Cliente cliRegistrar = new Cliente();
                cliRegistrar.setDocumento(documentoRegistrar);
                cliRegistrar.setNombre(nombreRegistrar);
                cliRegistrar.setApellido(apellidoRegistrar);
                cliRegistrar.setEmail(emailRegistrar);
                cliRegistrar.setEstado(estadoRegistrar);

                int resultRegistrar = ClienteDao.registrarCliente(cliRegistrar);

                if (resultRegistrar > 0) {
                    String registroExitoso = "Cliente registrado correctamente";
                    response.sendRedirect(request.getContextPath() + "/caja/clientes/cartera.jsp?registroExitoso=" + registroExitoso + "&page=1");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
            
            case "actualizar":
                try {
                    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                    String documento = request.getParameter("documento");
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String email = request.getParameter("email");
                    //int estado = Integer.parseInt(request.getParameter("estado"));
                    
                    ClienteDao cliDao = new ClienteDao();
                    StringBuilder mensajeError = new StringBuilder();
                    
                    if (cliDao.validarEmailExcepto(email, idCliente)) {
                        mensajeError.append("<div class=\"alert alert-danger\">Este correo electrónico se encuentra en uso. Por favor, ingresa uno diferente.</div>");
                    }
                    
                    if (cliDao.validarIdExcepto(documento, idCliente)) {
                        mensajeError.append("<div class=\"alert alert-danger\">Este DNI/RUC se encuentra en uso. Por favor, ingresa uno diferente.</div>");
                    }
                    
                    if (mensajeError.length() > 0) {
                        request.setAttribute("mensajeError", mensajeError.toString());
                        request.setAttribute("idCliente", idCliente);
                        request.setAttribute("documento", documento);
                        request.setAttribute("nombre", nombre);
                        request.setAttribute("apellido", apellido);
                        request.setAttribute("email", email);
                        request.getRequestDispatcher("caja/clientes/actualizar.jsp").forward(request, response);
                        return;
                    }
                     
                    Cliente cliente = new Cliente();
                    cliente.setIdCliente(idCliente);
                    cliente.setDocumento(documento);
                    cliente.setNombre(nombre);
                    cliente.setApellido(apellido);
                    cliente.setEmail(email);
                    //cliente.setEstado(estado);
                    
                    
                    int result = ClienteDao.actualizarCliente(cliente);
                    
                    if (result > 0) {
                        String actualizarExitoso = "Cliente actualizado correctamente";
                        response.sendRedirect(request.getContextPath() + "/caja/clientes/cartera.jsp?actualizarExitoso=" + actualizarExitoso + "&page=1");
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
