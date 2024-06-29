package controller;

import java.io.*;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.*;
import model.Producto;

@MultipartConfig
@WebServlet(name = "controlProducto", value = "/controlProducto")
public class controlProducto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action) {

            case "actualizar":
                try {
                    String nombreRegistrar = request.getParameter("nombre");
                    Part filePart = request.getPart("image");
                    String foto = request.getParameter("foto");
                    Producto producto = new Producto();
                    producto.setFoto(foto);
                    if (filePart != null && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        String fileName = filePart.getSubmittedFileName();
                        String uploadDir = getServletContext().getRealPath("/") + "cloud-images/";
                        uploadDir = uploadDir.replace("\\", "/");
                        File file = new File(uploadDir + nombreRegistrar + fileName);

                        try (InputStream fileContent = filePart.getInputStream(); OutputStream out = new FileOutputStream(file)) {
                            int read;
                            byte[] bytes = new byte[1024];
                            while ((read = fileContent.read(bytes)) != -1) {
                                out.write(bytes, 0, read);
                            }
                            System.out.println("Imagen cargada");
                        }

//                    response.getWriter().println("Imagen subida exitosamente.");
                        System.out.println("Imagen guardada");

                        producto.setFoto(nombreRegistrar + fileName);
                    }


                    int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                    int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
                    String nombre = request.getParameter("nombre");
                    String descripcion = request.getParameter("descripcion");


                    double precio = Double.parseDouble(request.getParameter("precio"));
                    int stock = Integer.parseInt(request.getParameter("stock"));
                    System.out.println("Obtener Parametros");

                    
                    ProductoDao ProductoDao = new ProductoDao();
                    StringBuilder mensajeError = new StringBuilder();
                            
                    if (ProductoDao.validarNombreExcepto(nombre, idProducto)) {
                        mensajeError.append("Este nombre se encuentra en uso. Por favor, ingresa uno diferente.");
                    }
                    

                    if (mensajeError.length() > 0) {
                        request.setAttribute("mensajeError", mensajeError.toString());
                        request.setAttribute("idProducto", idProducto);
                        request.setAttribute("idCategoria", idCategoria);
                        request.setAttribute("nombre", nombre);
                        request.setAttribute("descripcion", descripcion);
                        request.setAttribute("foto", foto);
                        request.setAttribute("precio", precio);
                        request.setAttribute("stock", stock);
                        System.out.println("Envio de parametros");
                        request.getRequestDispatcher("almacen/productos/actualizar.jsp").forward(request, response);
                        System.out.println("Redireccion");
                        return;
                    }
                    

                        producto.setIdProducto(idProducto);
                        producto.setIdCategoria(idCategoria);
                        producto.setNombre(nombre);
                        producto.setDescripcion(descripcion);

                        producto.setPrecio(precio);
                        producto.setStock(stock);
                        System.out.println("Dar Parametros");

                        int resultActualizar = ProductoDao.actualizarProducto(producto);

                        if (resultActualizar > 0) {
                            String actualizarExitoso = "Producto actualizado correctamente";
                            response.sendRedirect(request.getContextPath() + "/almacen/productos.jsp?actualizarExitoso=" + actualizarExitoso + "&page=1");

                        } /*else {  // Manejo de error de actualización
                            response.sendRedirect(request.getContextPath() + "/almacen/productos/actualizar.jsp?id=" + idProducto + "&error=ErrorActualizacion");

                        }*/

                } catch (Exception e) {
                    e.printStackTrace();
                    //request.setAttribute("mensajeError", "Error al actualizar el producto.");
                    //request.getRequestDispatcher("almacen/productos/actualizar.jsp").forward(request, response);
                }
                return;

            case "registrar":
                try {
                    Producto productoRegistrar = new Producto();
                    String nombreRegistrar = request.getParameter("nombre");
                    Part filePart = request.getPart("image");
                    productoRegistrar.setFoto("no-image.png");
                    if (filePart != null && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                        String fileName = filePart.getSubmittedFileName();
                        String uploadDir = getServletContext().getRealPath("/") + "cloud-images/";
                        uploadDir = uploadDir.replace("\\", "/");
                        File file = new File(uploadDir + nombreRegistrar + fileName);

                        try (InputStream fileContent = filePart.getInputStream(); OutputStream out = new FileOutputStream(file)) {
                            int read;
                            byte[] bytes = new byte[1024];
                            while ((read = fileContent.read(bytes)) != -1) {
                                out.write(bytes, 0, read);
                            }
                            System.out.println("Imagen cargada");
                        }

//                    response.getWriter().println("Imagen subida exitosamente.");
                        System.out.println("Imagen guardada");

                        productoRegistrar.setFoto(nombreRegistrar + fileName);
                    }

                    int idCategoriaRegistrar = Integer.parseInt(request.getParameter("idCategoria"));
                    String descripcionRegistrar = request.getParameter("descripcion");
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
                        request.setAttribute("precio", precioRegistrar);
                        request.setAttribute("stock", stockRegistrar);
                        request.setAttribute("estado", estadoRegistrar);
                        System.out.println("Envio de parametros");
                        request.getRequestDispatcher("almacen/productos/registrar.jsp").forward(request, response);
                        System.out.println("Redireccion");
                        return;
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                    productoRegistrar.setIdCategoria(idCategoriaRegistrar);
                    productoRegistrar.setNombre(nombreRegistrar);
                    productoRegistrar.setDescripcion(descripcionRegistrar);
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
                } catch (Exception e) {
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
                int idProducto = Integer.parseInt(request.getParameter("id"));
                Producto producto = ProductoDao.obtenerProductoPorId(idProducto);
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("/almacen/productos/actualizar.jsp").forward(request, response);
                return;
        }
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
