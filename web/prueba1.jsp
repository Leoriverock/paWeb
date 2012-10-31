<%-- 
    Document   : prueba1
    Created on : 22-oct-2012, 15:57:52
    Author     : claudio
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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


String ip = request.getParameter("ip");
String so = request.getParameter("so");
String cliente = request.getParameter("cliente");
String fecha = request.getParameter("fecha");

 ManejadorBD mbd= ManejadorBD.getInstancia();
 if(mbd.registrosi(fecha, ip))
 {
     mbd.registro(ip, so, cliente, fecha);
 }
 

%>
        
        <script type="text/javascript">
            
        </script>
    </body>
        
</html>
