<%-- 
    Document   : ApuestaGoleador
    Created on : 27-oct-2012, 10:06:29
    Author     : Usaurio
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apostar A Goleador</title>
    </head>
    <body>
        <h3>Apostar goleador de campeonato</h3>
        <% if(session.getAttribute("username")==null){ %>
    <div class="alert alert-error">
        <span>Error: </span>debe autenticarse primero.
    </div>
   <% } else {
            
            String div = request.getParameter("div");
            double dividendo = Double.parseDouble(div);
            String id_j = request.getParameter("id_j");
            int id_jugador = Integer.parseInt(id_j);
            String id_c = request.getParameter("id_c");
            int id_comp = Integer.parseInt(id_c);
            String apuesta = request.getParameter("monto");
            double monto = Double.parseDouble(apuesta);
            
            ManejadorBD mbd = ManejadorBD.getInstancia();
            ResultSet user= mbd.getStatement().executeQuery("select * from usuarios where nick='"+session.getAttribute("username")+"'");
            
            user.next();
            double saldo=user.getDouble("saldo");
            int id_u = user.getInt("id_user");
            
            if (saldo >= monto){
                ResultSet jugaador = mbd.getStatement().executeQuery("select * from jugadores j, competiciones c where id_jugador="+id_jugador+" and id_competicion="+id_comp+"");
                jugaador.next();
                out.println("Usted esta apostando $"+monto+" a que en la liga "+jugaador.getString("c.nombre")+" el jugador "+jugaador.getString("j.nombre")+" será el goleador.</br>");  
                out.println("Su saldo sería de $"+(saldo-monto)+".</br>");
                out.println("Paga: "+dividendo+".</br>");
                out.println("En caso de ganar usted ganaría $"+monto * dividendo+".</br>");
                %>
                <form action="ApuestaGoleadorABD.jsp">
                    <input type="hidden" value="<%=id_jugador%>" name="id_j">
                    <input type="hidden" value="<%=id_comp%>" name="id_comp">
                    <input type="hidden" value="<%=dividendo%>" name="div">
                    <input type="hidden" value="<%=monto%>" name="monto">
                    <input type="hidden" value="<%=id_u%>" name="user">
                    <input type="submit" value="Confirmar">
                </form>
            <%} else {
                    
                }
            
    %>
        
    
    <%        
            
            
            
            
   }%>
    </body>
</html>
