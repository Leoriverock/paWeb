<%@page import="Clases.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
    
    String competicion = request.getParameter("idc");
    int idcmp = Integer.parseInt(competicion);
    String equipo = request.getParameter("ide");
    int idequipo = Integer.parseInt(equipo);
    String apuesta = request.getParameter("ap");
    int plata = Integer.parseInt(apuesta);
    String nickuser = request.getParameter("user");
    
    mbd.getStatement().executeUpdate("insert into apuestas(usuario, monto, tipo) values('"+nickuser+"',"+plata+", 'Campeon') ");
    ResultSet id_ap = mbd.getStatement().executeQuery("select MAX id_apuesta from apuestas");
    int id_apuesta=0;
    while (id_ap.next()){
        id_apuesta=id_ap.getInt(0);
    }
    mbd.getStatement().executeUpdate("insert into ap_campeon(id_ap, equipo, comp) values("+id_apuesta+", "+idequipo+", "+idcmp+")");
    mbd.getStatement().executeUpdate("update usuarios set saldo=(saldo-"+plata+") where nick='"+nickuser+"' ");
    
    
%>  
    <p>Apuesta realizada! redireccionando...</p>
    <script>window.location.href='index.jsp';</script>