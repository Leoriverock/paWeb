<%

     String activo =(String)session.getAttribute("username");
    if(activo!=null)
        {
            session.removeAttribute(activo);
            session.invalidate();
        }
     else 
         {
         out.println("No te has logueado aun<a href=\"index.jsp\">Back</a>");
     }



%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--Redireccion automatica cuando doy cerrar sesion-->
<jsp:forward page="index.jsp"/>