<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
    if (request.getParameter("agregar")!=null){
        try{
            double agr= Double.parseDouble(request.getParameter("agregar"));
            ResultSet saldoAct = mbd.getStatement().executeQuery("select saldo from usuarios where nick='"+session.getAttribute("username")+"'");
            double saldoAnterior=0;
            while(saldoAct.next()){
                saldoAnterior= Double.parseDouble(saldoAct.getObject("saldo").toString());
            }
            
            double nuevoSaldo=saldoAnterior+agr;
            try{
            mbd.getStatement().executeUpdate("update usuarios set saldo="+nuevoSaldo+" where nick='"+session.getAttribute("username")+"'");
            } catch (SQLException ex){
                %><script>alert("Puto Error");
            window.location.href='index.jsp';</script><%
            }
            %><script>alert("Se ha acreditado con exito");
            window.location.href='index.jsp';</script><%
        }catch(Exception ex){
            %><script>alert("Error");
            window.location.href='index.jsp';</script><%
        }
    }
%> 
