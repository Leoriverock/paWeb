<%-- 
    Document   : newjsp
    Created on : 23-sep-2012, 0:17:42
    Author     : Usuario
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
        String user = request.getParameter("q");
        ResultSet res = null;
       try{
            res = mbd.consultarUsuario(request.getParameter("q"));
            if(!user.equals("")){
            if(res.next()){
               %>
               <h5><span class="label label-important">No Disponible</span></h5>
               <%
            } else {
               %>
               <h5><span class="label label-success">Disponible</span></h5>
               <% 
            }
                       } else {
                           %>
               <h5><span class="label label-info">Ingrese nick</span></h5>
               <% 
                       }
                
         } catch(SQLException ex){
                       out.println("Error: "+ex);}
%>                   
       
                  
    </body>
</html>
