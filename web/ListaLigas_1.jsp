<%-- 
    Document   : ApuestaCampeon
    Created on : 02-oct-2012, 18:18:14
    Author     : Usaurio
--%>

<%@page import="Clases.ManejadorBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quien ganará este campeonato?</title>
    </head>
    <body>
        <h3>Aqui usted podrá apostar por quién será el campeón de esta liga...</h3>
            <form method="POST" action="DividendoCampeon.jsp.jsp">
                <h4></h4>    
            <table class="table table-bordered">
                <%
                //tabla con links a detalle de jugador
                ManejadorBD mbd= ManejadorBD.getInstancia();
                
                try{
                    ResultSet liga= mbd.getStatement().executeQuery("select * from competiciones where tipo='Liga'");
                    while(liga.next()){
                        out.println("<tr>");
                        out.println("<td><a href=DividendoCampeon.jsp?cod="+liga.getObject("id_competicion")+">"+liga.getObject("Nombre")+"</a></td>");
                        out.println("</tr>");
                    }
                } catch(Exception ex){
                    out.println("<h2>error en la consulta de jugadores</h2>");
                }
                %>
            </table>
        
    </body>
</html>
