<%-- 
    Document   : ApostarResultado
    Created on : 09-oct-2012, 3:00:27
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cuál será el resultado de este partido?</title>
    </head>
    <body>
        <h3>Partido</h3>
        <%
            String cod = request.getParameter("id_part");
            int part = Integer.parseInt(cod);
            String res = request.getParameter("res");
            ManejadorBD mbd = ManejadorBD.getInstancia();
            ResultSet partido= mbd.getStatement().executeQuery("select * from competiciones c, equipos el,"+
                    "equipos ev, partidos p where finalizado=0 and p.id_comp=c.id_competicion and el.id_equipos=p.equipolocal"+
                    " and ev.id_equipos=p.equipovisita and p.id_partido="+part+"");
            partido.next();
            out.println(partido.getObject("el.nombre")+"  vs  "+partido.getObject("ev.nombre")+"</br>");
            
            if (res.equals("1")){
                out.println("Local paga: "+partido.getObject("p.divlocal"));
            } else if (res.equals("x")){
                out.println("Empate paga: "+partido.getObject("p.divempate"));
            } else if (res.equals("2")){
                out.println("Visitante paga: "+partido.getObject("p.divvisita"));
            }
        %>
        <form action="ConfirmarApuesta.jsp" method="post">
            <label>Monto </label><input type="text" name="plata">
            <input type="hidden" name="resultado" value="<%=res%>" />
            <input type="hidden" name="id_p" value="<%=part%>" />
            <input type="submit" value="Apostar">
        </form>
    </body>
</html>
