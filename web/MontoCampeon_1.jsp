<%-- 
    Document   : MontoCampeon
    Created on : 03-oct-2012, 4:04:30
    Author     : Usaurio
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="Clases.ManejadorBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" import="Clases.*, java.lang.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ibet</title>
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="Estilo.css" rel="stylesheet">
    </head>
    <body>
        <form action="apostar.jsp" method="POST">
        <table>
        <%
        String ide = request.getParameter("ideq");
        int id_e = Integer.parseInt(ide);
        String idc = request.getParameter("idcomp");
        int id_c = Integer.parseInt(idc);
        ManejadorBD mbd= ManejadorBD.getInstancia();
        double divide=4.0;
        try{
                        out.println("<h3>hola</h3>");

        ResultSet res= mbd.getStatement().executeQuery("select * from liga_equipo, equipos where id_liga="+id_c+" and id_equipo="+id_e+" and id_equipo=id_equipos");
        
        while (res.next()){
            divide= res.getDouble("dividendo");
            out.println("<tr><td>"+res.getObject("nombre")+"</td>");
            out.println("<td id=divs>"+res.getObject("dividendo")+"</td>");
            out.println("<td>");
            
    %>
            <input type="Text" name="monto">
            </td><td>
            <input type="submit" class="btn" value="Ingresar">
            <%
            out.println("</td></tr>");
        }
               } catch (SQLException e){
                   out.println("error"+e.toString());
               }
        %>
        </table>
        
        <input type="hidden" id="competicion"  value="<%=id_c%>" name="comp"/>
        <input type="hidden" id="equipo" value="<%=id_e%>"  name="eq"/>
        <input type="hidden" id="divi" value="<%=divide%>"  name="dvd"/>
        </form>
    </body>
</html>
