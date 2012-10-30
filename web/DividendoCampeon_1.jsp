<%-- 
    Document   : DividendoCampeon
    Created on : 03-oct-2012, 1:56:35
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apuesta campeón!</title>
    </head>
    <body>
        <h1>Aqui el usuario deberá elegir el equipo que cree saldrá campeón de esta competicion</h1>
            <table>
                <%
                String id = request.getParameter("cod");
                int ID = Integer.parseInt(id);
                ManejadorBD mbd = ManejadorBD.getInstancia();
                ResultSet eq = mbd.getStatement().executeQuery("select * from liga_equipo, equipos where id_liga="+ID+" and id_equipos=id_equipo");
                out.println("<tr>");
                out.println("<td><a>Equipo</a></td>");
                out.println("<td><a>Dividendo</a></td>");
                out.println("</tr>");   
                while(eq.next()){
                    out.println("<tr>");
                    out.println("<td><a href=MontoCampeon.jsp?ideq="+eq.getObject("id_equipo")+"&idcomp="+id+">"+eq.getObject("nombre") +"</a></td>");
                    out.println("<td><a>"+eq.getObject("dividendo") +"</a></td>");
                    out.println("</tr>");
                }
                %>
                </tr>
            </table>
    </body>
</html>
