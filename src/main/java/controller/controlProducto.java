package controller;

import java.io.*;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Producto;



/*import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;*/
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

                    // Obtener la ruta del directorio de despliegue del proyecto en el servidor de aplicaciones
                    String uploadDir = getServletContext().getRealPath("/") + "uploads/";

                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdirs(); // Crear el directorio si no existe
                    }

                    File file = new File(uploadDir + fileName);

                    try (InputStream fileContent = filePart.getInputStream();
                         OutputStream out = new FileOutputStream(file)) {
                        int read;
                        byte[] bytes = new byte[1024];
                        while ((read = fileContent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }
                    }

//                    response.getWriter().println("Imagen subida exitosamente.");

                    int idCategoriaRegistrar = Integer.parseInt(request.getParameter("idCategoria"));
                    String nombreRegistrar = new String(request.getParameter("nombre").getBytes("ISO-8859-1"), "UTF-8");
//                    String nombreRegistrar = request.getParameter("nombre");
                    String descripcionRegistrar = request.getParameter("descripcion");
                    String fotoRegistrar = String.valueOf(file);
                    double precioRegistrar = Double.parseDouble(request.getParameter("precio"));
                    int stockRegistrar = Integer.parseInt(request.getParameter("stock"));
                    int estadoRegistrar = Integer.parseInt(request.getParameter("estado"));

                    Producto productoRegistrar = new Producto();
                    productoRegistrar.setIdCategoria(idCategoriaRegistrar);
                    productoRegistrar.setNombre(nombreRegistrar);
                    productoRegistrar.setDescripcion(descripcionRegistrar);
                    productoRegistrar.setFoto(fotoRegistrar);
                    productoRegistrar.setPrecio(precioRegistrar);
                    productoRegistrar.setStock(stockRegistrar);
                    productoRegistrar.setEstado(estadoRegistrar);
                    response.setContentType("text/html;charset=UTF-8");
                    int resultRegistrar = ProductoDao.registrarProducto(productoRegistrar);

                    if (resultRegistrar > 0) {
                        response.sendRedirect(request.getContextPath() + "/almacen/productos.jsp");
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