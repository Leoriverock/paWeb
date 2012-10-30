<%@page import="Clases.Usuarios"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
    
    String nombre = null;
            nombre = request.getParameter("in_usuario");
    String pass = null;
          pass = request.getParameter("pass_usuario");
    Usuarios u = new Usuarios();
    try{
            ResultSet res = mbd.login(request.getParameter("in_usuario"));
            res.next();
            u.setNombre(res.getObject("nick").toString());
            u.setPassword(res.getObject("password").toString());
                       }catch(SQLException ex){
                       out.println("Error: "+ex);}
    if(nombre==null){
                        %><script>alert("Datos incorrectos");
                       window.location.href='index.jsp';</script><%
    }                   
       else if(nombre != null && pass !=null){
        if(nombre.toLowerCase().trim().equals(u.getNombre().toLowerCase().trim())){
            if(pass.equals(u.getPassword())){
                session.setAttribute("username", nombre);
                %><p>Bienvenido... redireccionando</p>
                <script>window.location.href='index.jsp';</script><%
            }
            else{
                        %>
                        <div class="alert alert-error">
                            <strong>Error</strong>el password no coincide
                        </div>    
                        <script>window.location.href='index.jsp';</script><%
                       
                       }
         }
                     else{
                       %><script>alert("El usuario no existe");
                       window.location.href='index.jsp';</script><%
                       }
        
            
    }
       else{
                        %><script>alert("Datos incorrectos");
                       window.location.href='index.jsp';</script><%
       }
%> 
