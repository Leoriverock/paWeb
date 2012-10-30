<%-- 
    Document   : ApuestaPartido
    Created on : 02-oct-2012, 18:42:20
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quién ganará éste partido?</title>
    </head>
    <body>
        <h3>Aquí usted podrá apostar el resultado de un partido...</h3>
        <table border="1">
            <tr>
                <td>Local</td><td></td><td>Visitante</td><td>Competición</td>
                <td>1</td><td>X</td><td>2</td>
            </tr>

                <%
                    ManejadorBD mbd = ManejadorBD.getInstancia();
                    ResultSet partido= mbd.getStatement().executeQuery("select * from competiciones c, equipos el,"+
                    "equipos ev, partidos p where finalizado=0 and p.id_comp=c.id_competicion and el.id_equipos=p.equipolocal"+
                    " and ev.id_equipos=p.equipovisita");
                    while (partido.next())
                    {
                       out.println("<tr>");
                       out.println("<td><a>"+partido.getObject("el.nombre") +"</a></td>");
                       out.println("<td><a><center>vs</center></a></td>");
                       out.println("<td><a>"+partido.getObject("ev.nombre") +"</a></td>");
                       out.println("<td><a>"+partido.getObject("c.nombre")+" ("+partido.getObject("c.tipo")+")</a></td>");
                       out.println("<td><a href=ApostarResultado.jsp?id_part="+partido.getObject("p.id_partido")+"&res=1>"+partido.getObject("p.divlocal") +"</a></td>");
                       out.println("<td><a href=ApostarResultado.jsp?id_part="+partido.getObject("p.id_partido")+"&res=x>"+partido.getObject("p.divempate") +"</a></td>");
                       out.println("<td><a href=ApostarResultado.jsp?id_part="+partido.getObject("p.id_partido")+"&res=2>"+partido.getObject("p.divvisita") +"</a></td>");
                       out.println("</tr>");
                       
                       }


                %>
        </table>
    </body>
</html>
