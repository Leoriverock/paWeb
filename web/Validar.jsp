

<%@page import="Clases.Usuarios"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    Usuarios u = new Usuarios();
    u.setLogin(request.getParameter("login_usuario"));
    u.setNombre(request.getParameter("nombre_usuario"));
    u.setEmail(request.getParameter("email_usuario"));
    u.setPassword(request.getParameter("contrasenia_usuario"));
    String r_pass = request.getParameter("r_contrasenia_usuario");
    u.setTelefono(request.getParameter("tel_usuario"));
    u.setDireccion(request.getParameter("dir_usuario"));
    u.setDocumento(request.getParameter("doc_usuario"));
    u.setSexo(request.getParameter("sexo_usuario"));
    u.setFecha(request.getParameter("nacimiento_usuario"));
    u.setPais(request.getParameter("pais_usuario"));
    
     if(u.getNombre().isEmpty() || u.getEmail().isEmpty() || u.getPassword().isEmpty() || r_pass.isEmpty() || u.getSexo().isEmpty() || u.getPais().isEmpty() ){
        %><script>alert("Error: No puede haber campos vacios");
        window.location.href='Registro_Usuario.jsp';</script><%
    }else{
      if(u.getPassword().equals(r_pass)){
            u.Registro_Usuario();  
          %><script>alert("Usuario Creado con exito");
            window.location.href='index.jsp';</script><%
        }
        else{
            %><script>alert("Error: la password no coincide");
            window.location.href='Registro_Usuario.jsp';</script><%
        }
    
    }
    
    
 
%>
