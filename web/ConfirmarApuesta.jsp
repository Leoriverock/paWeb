<%-- 
    Document   : apuesta
    Created on : 09-oct-2012, 4:12:17
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String apuesta= request.getParameter("plata");
            int monto=Integer.parseInt(apuesta);

            String id_partido= request.getParameter("id_p");

            String res= request.getParameter("resultado");
            
            ManejadorBD mbd = ManejadorBD.getInstancia();
            ResultSet partido= mbd.getStatement().executeQuery("select * from competiciones c, equipos el,"+
                    "equipos ev, partidos p where finalizado=0 and p.id_comp=c.id_competicion and el.id_equipos=p.equipolocal"+
                    " and ev.id_equipos=p.equipovisita and p.id_partido="+id_partido+"");
            partido.next();
            
        %>
        <h3>Esta apostando al partdido <%out.println(partido.getObject("el.nombre")+"  vs  "+partido.getObject("ev.nombre"));%></h3>
        <%
            if (res.equals("1")){
                out.println("Apuesta A Local</br>Dinero apostado: $"+monto+"</br>Paga: "+partido.getObject("p.divlocal"));
                out.println("</br>En caso de acertar usted ganaría $"+monto*partido.getDouble("p.divlocal"));
            } else if (res.equals("x")){
                out.println("Apuesta A Empate</br>Paga: "+partido.getObject("p.divempate"));
                out.println("</br>En caso de acertar usted ganaría $"+monto*partido.getDouble("p.divempate"));
            } else if (res.equals("2")){
                out.println("Apuesta A Visitante</br>Paga: "+partido.getObject("p.divvisita"));
                out.println("</br>En caso de acertar usted ganaría $"+monto*partido.getDouble("p.divvisita"));
            }
        %>
        <form action="ApuestaResultado.jsp" method="post">
            <input type="hidden" name="resultado" value="<%=res%>" />
            <input type="hidden" name="partido" value="<%=id_partido%>" />
            <input type="hidden" name="monto" value="<%=monto%>" />
            <input type="submit" value="Aceptar">
        </form>
    </body>
</html>
