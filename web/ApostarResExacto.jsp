<%-- 
    Document   : ApostarResExacto
    Created on : 25-oct-2012, 11:31:30
    Author     : Usaurio
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apostar Resultado Exacto</title>
    </head>
    <body>
        <h3>Aqui usted podrá elegir un partido y apostar al resultado exacto del mismo...</h3>
        <table border="1">
            <tr>
                <td>Local</td><td>&</td><td>Visitante</td><td>Competición</td>
                <td>Div</td>
            </tr>

                <%
                    ManejadorBD mbd = ManejadorBD.getInstancia();
                    ResultSet partido= mbd.getStatement().executeQuery("select * from competiciones c, equipos el,"+
                    "equipos ev, partidos p where finalizado=0 and p.id_comp=c.id_competicion and el.id_equipos=p.equipolocal"+
                    " and ev.id_equipos=p.equipovisita");
                    while (partido.next())
                    {
                       out.println("<tr>");
                       out.println("<td><a href=MontoApResEx.jsp?id_part="+partido.getObject("p.id_partido")+">"+partido.getObject("el.nombre") +"</a></td>");
                       out.println("<td><a href=MontoApResEx.jsp?id_part="+partido.getObject("p.id_partido")+"><center></center></a></td>");
                       out.println("<td><a href=MontoApResEx.jsp?id_part="+partido.getObject("p.id_partido")+">"+partido.getObject("ev.nombre") +"</a></td>");
                       out.println("<td><a href=MontoApResEx.jsp?id_part="+partido.getObject("p.id_partido")+">"+partido.getObject("c.nombre")+" ("+partido.getObject("c.tipo")+")</a></td>");
                       out.println("<td><a href=MontoApResEx.jsp?id_part="+partido.getObject("p.id_partido")+">"+partido.getObject("p.div_exacto") +"</a></td>");
                       out.println("</tr>");
                       
                       }


                %>
        </table>
    </body>
</html>
