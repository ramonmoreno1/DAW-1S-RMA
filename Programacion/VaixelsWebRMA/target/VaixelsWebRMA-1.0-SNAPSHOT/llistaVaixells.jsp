<%-- 
    Document   : llistaVaixels
    Created on : 23 mar 2024, 7:59:24
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lloguervaixells.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  ArrayList<Vaixell> vaixels = (ArrayList<Vaixell> )session.getAttribute("vaixels"); %> <%-- pendiente de definir pero funciona--%>
        <%for (Vaixell vaixell : vaixels) {
              out.print(""+vaixell.toString());
        
            }%>
        <h1>Aquí la lista de Barcos</h1>
    </body>
</html>
