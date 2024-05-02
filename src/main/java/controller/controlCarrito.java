package controller;

import java.io.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Carrito;
import model.Producto;


/*import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;*/

@WebServlet(name = "controlCarrito", value = "/controlCarrito")
public class controlCarrito extends HttpServlet {

    ProductoDao productoDao = new ProductoDao();
    Producto p = new Producto();
//    List<Producto> Productos = new ArrayList<>();

//    List<Carrito> listaCarrito = new ArrayList<>();

    int item;
    double totalPagar = 0.0;
    int cantidad = 1;
    double subtotal;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //        Mantener los productos del carrito guardados en el navegador
        HttpSession sessionCart = request.getSession();
        List<Carrito> listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
        if (listaCarrito == null) {
            listaCarrito = new ArrayList<>();
            sessionCart.setAttribute("carrito", listaCarrito);
        }

        DecimalFormat df = new DecimalFormat("#.##");
        String accion = request.getParameter("accion");

        String menu = null;
        int categoria = 0;

        switch(accion){
            case "Carrito":
                totalPagar = 0.0;
                listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
                request.setAttribute("carrito", listaCarrito);
                if (listaCarrito.isEmpty()) {
//                    request.getRequestDispatcher("views/viewCliente/venta/pago/carrito.jsp").forward(request, response);
                    totalPagar = 0.0;
                    request.setAttribute("totalPagar", totalPagar);
                } else {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        totalPagar = totalPagar + listaCarrito.get(i).getSubtotal();
                    }
                    request.setAttribute("totalPagar", totalPagar);
                }

                request.getRequestDispatcher("caja/carrito.jsp").forward(request, response);
                break;

            case "AgregarCarrito":
                int pos = 0;
                cantidad = 1;
                int idProducto = Integer.parseInt(request.getParameter("id"));
                p = productoDao.listarId(idProducto);

                if (listaCarrito.size() > 0) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (idProducto == listaCarrito.get(i).getIdProducto()) {
                            pos = i;
                        }
                    }
                    if (idProducto == listaCarrito.get(pos).getIdProducto()) {
                        categoria = p.getIdCategoria();
                        cantidad = listaCarrito.get(pos).getCantidad() + cantidad;
                        double subtotal = listaCarrito.get(pos).getPrecio() * cantidad;
                        listaCarrito.get(pos).setCantidad(cantidad);
                        String subtotalString = df.format(subtotal);
                        listaCarrito.get(pos).setSubtotal(Double.parseDouble(subtotalString));
                        double totalPagar = 0.0;
                        for (int i = 0; i < listaCarrito.size(); i++) {
                            totalPagar = totalPagar + listaCarrito.get(i).getSubtotal();
                        }
                        request.setAttribute("totalPagar", totalPagar);
//                        listaCarrito.get(pos).setSubtotal(subtotal);

                    } else {
                        item = item + 1;
                        categoria = p.getIdCategoria();
                        Carrito car = new Carrito();
                        car.setItem(item);
                        car.setIdProducto(p.getIdProducto());
                        car.setNombre(p.getNombre());
                        car.setPrecio(p.getPrecio());
                        car.setCantidad(cantidad);
                        double subtotal = cantidad * p.getPrecio();
                        String subtotalString = df.format(subtotal);
                        car.setSubtotal(Double.parseDouble(subtotalString));

//                        car.setSubtotal(cantidad * p.getPrecio());
                        listaCarrito.add(car);
                    }

                } else {
                    item = item + 1;
                    categoria = p.getIdCategoria();
                    Carrito car = new Carrito();
                    car.setItem(item);
                    car.setIdProducto(p.getIdProducto());
                    car.setNombre(p.getNombre());
                    car.setPrecio(p.getPrecio());
                    car.setCantidad(cantidad);
                    double subtotal = cantidad * p.getPrecio();

                    String subtotalString = df.format(subtotal);
                    car.setSubtotal(Double.parseDouble(subtotalString));

//                    car.setSubtotal(cantidad * p.getPrecio());
                    listaCarrito.add(car);

                }

                request.setAttribute("contador", listaCarrito.size());
                request.getRequestDispatcher("caja/menu.jsp").forward(request, response);
                break;

            case "Delete":
//                totalPagar = 0.0;
                int idproducto = Integer.parseInt(request.getParameter("idp"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProducto() == idproducto) {
                        listaCarrito.remove(i);
                    }

                }
//                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("controlCarrito?accion=Carrito").forward(request, response);

                break;


        }


        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet direcServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet direcServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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