<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="java.io.IOException" %>
<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession(false);
    if(sesion != null){
        sesion.invalidate();
    }
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
