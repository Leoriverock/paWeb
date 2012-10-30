

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Apuestas Realizadas</title>
    </head>
    <body>
        <h3>Apuestas Campeon</h3>
        <table border="1">
            <%
            ManejadorBD mbd = ManejadorBD.getInstancia();
            ResultSet apuesta = mbd.getStatement().executeQuery("select * from apuestas a, liga_equipo d, usuarios u, ap_campeon ac, competiciones c, equipos e where a.id_apuesta=ac.id_apuesta and d.id_liga=c.id_competicion and d.id_equipo=ac.id_equipo and u.nick='"+session.getAttribute("username")+"' and u.id_user=a.id_usuario and a.id_comp=c.id_competicion and ac.id_equipo=e.id_equipos order by a.fecha desc");
            out.println("<tr>");
            out.println("<td><a>Evento</a></td>");
            out.println("<td><a>Tipo Apuesta</a></td>");
            out.println("<td><a>Realizada</a></td>");
            out.println("<td><a>Apuesta por</a></td>");
            out.println("<td><a>Apostado</a></td>");
            out.println("<td><a>Dividendo</a></td>");
            out.println("<td><a>Ganará</a></td>");
            out.println("<td><a>Estado</a></td>");
            out.println("</tr>");
            while(apuesta.next()){
                out.println("<tr>");
                out.println("<td><a>"+apuesta.getObject("c.nombre") +"</a></td>");
                out.println("<td><a>"+apuesta.getObject("a.tipo")+"</a></td>");
                out.println("<td><a>"+apuesta.getObject("a.fecha")+"</a></td>");
                out.println("<td><a>"+apuesta.getObject("e.nombre")+"</a></td>");
                out.println("<td><a> $ "+apuesta.getObject("a.monto")+"</a></td>");
                out.println("<td><a>"+apuesta.getDouble("d.dividendo") +"</a></td>");
                out.println("<td><a> $ "+apuesta.getInt("a.monto")*apuesta.getDouble("d.dividendo") +"</a></td>");
                out.println("<td><a>"+apuesta.getObject("a.estado") +"</a></td>");
                out.println("</tr>");
            }
            %>
        </table>
        <h3>Apuestas Partido</h3>
        <table border="1">
            <%
            
            ResultSet apuestap = mbd.getStatement().executeQuery("select * from apuestas a, partidos p, usuarios u, ap_partidos ap, equipos e1, equipos e2 where a.id_apuesta=ap.id_apuesta and p.id_partido=ap.id_partido and u.nick='"+session.getAttribute("username")+"' and u.id_user=a.id_usuario and p.equipolocal=e1.id_equipos and p.equipovisita=e2.id_equipos order by a.fecha desc");
            out.println("<tr>");
            out.println("<td><a>Evento</a></td>");
            out.println("<td><a>Tipo Apuesta</a></td>");
            out.println("<td><a>Realizada</a></td>");
            out.println("<td><a>Apuesta por</a></td>");
            out.println("<td><a>Apostado</a></td>");
            out.println("<td><a>Dividendo</a></td>");
            out.println("<td><a>Ganará</a></td>");
            out.println("<td><a>Estado</a></td>");
            out.println("</tr>");   
            
            while(apuestap.next()){
                out.println("<tr>");
                out.println("<td><a>"+apuestap.getObject("e1.nombre")+" vs "+apuestap.getObject("e2.nombre")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("a.tipo")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("a.fecha")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("ap.opcion")+"</a></td>");
                out.println("<td><a> $ "+apuestap.getObject("a.monto")+"</a></td>");
                if (apuestap.getString("ap.opcion").equals("local")){
                    out.println("<td><a>"+apuestap.getDouble("p.divlocal") +"</a></td>");
                    out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divlocal") +"</a></td>");
                    } else if (apuestap.getString("ap.opcion").equals("empate")){
                            out.println("<td><a>"+apuestap.getDouble("p.divempate") +"</a></td>");
                            out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divempate") +"</a></td>");
                        } else if (apuestap.getString("ap.opcion").equals("visitante")){
                            out.println("<td><a>"+apuestap.getInt("p.divvisita") +"</a></td>");
                            out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divvisita") +"</a></td>");
                        }
                out.println("<td><a>"+apuestap.getObject("a.estado") +"</a></td>");
                out.println("</tr>");
            
            }
            %>
        </table>
        
    </body>
</html>
