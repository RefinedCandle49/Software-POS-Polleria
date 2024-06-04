package controller;

import java.io.*;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Producto;

@MultipartConfig
@WebServlet(name = "controlProducto", value = "/controlProducto")
public class controlProducto extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action){
            case "registrar":
                try{

                    Part filePart = request.getPart("image");
                    String fileName = filePart.getSubmittedFileName();
                    String uploadDir = "C:/Users/daniel/Documents/GitHub/Software-POS-Polleria/src/main/webapp/cloud-images/"; // COMPLETAR LA RUTA
                    File file = new File(uploadDir + fileName);
                    

                    try (InputStream fileContent = filePart.getInputStream();
                         OutputStream out = new FileOutputStream(file)) {
                        int read;
                        byte[] bytes = new byte[1024];
                        while ((read = fileContent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }
                        System.out.println("Imagen cargada");
                    }

                    String ruta ="http://localhost:8080/" + request.getContextPath() + "/cloud-images/" + fileName;
//                    response.getWriter().println("Imagen subida exitosamente.");
                        System.out.println("Imagen guardada");

                    int idCategoriaRegistrar = Integer.parseInt(request.getParameter("idCategoria"));
                    String nombreRegistrar = request.getParameter("nombre");
                    String descripcionRegistrar = request.getParameter("descripcion");
                    String fotoRegistrar = fileName;
                    double precioRegistrar = Double.parseDouble(request.getParameter("precio"));
                    int stockRegistrar = Integer.parseInt(request.getParameter("stock"));
                    int estadoRegistrar = Integer.parseInt(request.getParameter("estado"));

                    // ERRORES //////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ProductoDao productoDao = new ProductoDao();
                    String mensajeError = null;

                    if (productoDao.validarProducto(nombreRegistrar)) {
                        mensajeError = "Este nombre de producto se encuentra en uso. Por favor, ingresa uno diferente.";
                        System.out.println("Nombre Repetido");
                    }

                    if (mensajeError != null) {
                        request.setAttribute("mensajeError", mensajeError);
                        request.setAttribute("idCategoria", idCategoriaRegistrar);
                        request.setAttribute("nombre", nombreRegistrar);
                        request.setAttribute("descripcion", descripcionRegistrar);
                        request.setAttribute("foto", fotoRegistrar);
                        request.setAttribute("precio", precioRegistrar);
                        request.setAttribute("stock", stockRegistrar);
                        request.setAttribute("estado", estadoRegistrar);
                        System.out.println("Envio de parametros");
                        request.getRequestDispatcher("almacen/productos/registrar.jsp").forward(request, response);
                        System.out.println("Redireccion");
                        return;
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    Producto productoRegistrar = new Producto();
                    productoRegistrar.setIdCategoria(idCategoriaRegistrar);
                    productoRegistrar.setNombre(nombreRegistrar);
                    productoRegistrar.setDescripcion(descripcionRegistrar);
                    productoRegistrar.setFoto(fotoRegistrar);
                    productoRegistrar.setPrecio(precioRegistrar);
                    productoRegistrar.setStock(stockRegistrar);
                    productoRegistrar.setEstado(estadoRegistrar);
                    response.setContentType("text/html;charset=UTF-8");
                    System.out.println("aquiiiiiiiiiiiiiii");
                    int resultRegistrar = ProductoDao.registrarProducto(productoRegistrar);
                    System.out.println("o aquiiiiiiiiiiiiiii");
                    
                    if (resultRegistrar > 0) {
                        String registroExitoso = "Producto registrado correctamente";
                        response.sendRedirect(request.getContextPath() + "/almacen/productos.jsp?registroExitoso=" + registroExitoso + "&page=1");
                    } else {
//                        request.setAttribute("errorRegistrarProd", "Error al registrar el producto.");
//                        request.getRequestDispatcher("/admin/register/producto.jsp").forward(request, response);
                    }
                } catch (Exception e){
//                    request.setAttribute("errorRegistrarProd", "Error al registrar el producto.");
//                    request.getRequestDispatcher("/admin/register/producto.jsp").forward(request, response);
                }
                return;

        }

        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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