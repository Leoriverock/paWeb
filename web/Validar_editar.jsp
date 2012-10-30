<%@page import="Clases.Usuarios"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%/*
Usuarios u = new Usuarios();
u.setDireccion(request.getParameter("dir"));
u.setPais(request.getParameter("pais"));
u.setTelefono(request.getParameter("telefono"));
u.setNombre(session.getAttribute("username").toString()); 
if(!u.getNombre().isEmpty()){
u.Editar_Registro();
} */
String direccion = request.getParameter("dir");
String country = request.getParameter("pais");
String tel = request.getParameter("telefono");
String user = session.getAttribute("username").toString();
ManejadorBD mbd = ManejadorBD.getInstancia();
mbd.getStatement().executeUpdate("UPDATE usuarios SET direccion = '"+direccion+"',pais = '"+country+"',telefono = '"+tel+"' WHERE nick = '"+user+"' ");
%>
<script>alert("Se han modificado los datos de usuario");
window.location.href='index.jsp';</script><%

%>