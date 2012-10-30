<%@page import="Clases.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
    
    String jug = request.getParameter("id_j");
    int id_j = Integer.parseInt(jug);
    String div = request.getParameter("div");
    double divd = Double.parseDouble(div);
    String competicion = request.getParameter("id_comp");
    int idcomp = Integer.parseInt(competicion);
    String apuesta = request.getParameter("monto");
    double plata2 = Double.parseDouble(apuesta);
    int plata = (int) plata2;   
    
    String id_u = request.getParameter("user");
    int id_user = Integer.parseInt(id_u);
    ResultSet user = mbd.getStatement().executeQuery("select * from usuarios where id_user="+id_user+"");
    user.next();
    
    
    mbd.getStatement().executeUpdate("insert into apuestas(id_usuario, monto, tipo, id_comp, fecha, estado) values('"+id_user+"',"+plata+", 'Goleador', "+idcomp+", '2012-10-27', 'pendiente') ");
    ResultSet id_ap = mbd.getStatement().executeQuery("select MAX(id_apuesta) from apuestas");
    int id_apuesta=0;
    id_ap.next();
        id_apuesta=id_ap.getInt(1);
    mbd.getStatement().executeUpdate("insert into ap_goleador_comp(id_apuesta, id_jugador, div_jug) values("+id_apuesta+", "+id_j+", '"+divd+"')");
    mbd.getStatement().executeUpdate("update usuarios set saldo=(saldo-"+plata+") where id_user="+id_user+"");
    
    
%> 
 <script>alert("Apuesta Concretada!");
 window.location.href='index.jsp';</script>