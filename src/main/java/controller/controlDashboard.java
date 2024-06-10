package controller;

import java.io.*;
import java.util.List;

import dao.VentaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Venta;

@WebServlet(name = "controlDashboard", value = "/controlDashboard")
public class controlDashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        switch (accion) {
            case "buscarVentas":
                VentaDao dao = new VentaDao();
                String desde = request.getParameter("desde");
                String hasta = request.getParameter("hasta");
                request.setAttribute("desde", desde);
                request.setAttribute("hasta", hasta);

                request.getRequestDispatcher("admin/ventas/export.jsp?page=1").forward(request, response);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}