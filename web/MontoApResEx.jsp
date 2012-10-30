<%-- 
    Document   : MontoApResEx
    Created on : 25-oct-2012, 12:10:56
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apuesta!</title>
    </head>
    <body>
        
        <h3>Partido</h3>
        <%
            String cod = request.getParameter("id_part");
            int part = Integer.parseInt(cod);
            ManejadorBD mbd = ManejadorBD.getInstancia();
            ResultSet partido= mbd.getStatement().executeQuery("select * from competiciones c, equipos el,"+
                    "equipos ev, partidos p where finalizado=0 and p.id_comp=c.id_competicion and el.id_equipos=p.equipolocal"+
                    " and ev.id_equipos=p.equipovisita and p.id_partido="+part+"");
            partido.next();
            out.println(partido.getObject("el.nombre")+"  vs  "+partido.getObject("ev.nombre")+"</br>");
            out.println("Dividendo: "+partido.getObject("p.div_exacto"));
            
        %>
        <form action="ConfirmaApuesta.jsp" method="post">
            <h3>Ingrese los goles de cada equipo</h3>
            <label>Resultado</label><input type="text" name="goles_local" size="1">
            <label>-</label><input type="text" name="goles_visita" size="1">
            </br>
            <label>Monto </label><input type="text" name="plata" size="3">
            <input type="hidden" name="id_p" value="<%=part%>" />
            <input type="submit" value="Apostar">
        </form>
    </body>
</html>