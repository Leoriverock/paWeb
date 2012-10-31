<%@page import="Clases.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    ManejadorBD mbd = ManejadorBD.getInstancia();   
    
    String competicion = request.getParameter("idc");
    int idcomp = Integer.parseInt(competicion);
    String equipo = request.getParameter("ide");
    int idequipo = Integer.parseInt(equipo);
    String apuesta = request.getParameter("ap");
    double plata2 = Double.parseDouble(apuesta);
    int plata = (int) plata2;   
    
    String nickuser = request.getParameter("user");
    ResultSet user = mbd.getStatement().executeQuery("select * from usuarios where nick='"+nickuser+"'");
    user.next();
    int id_user= user.getInt("id_user");
    
    mbd.getStatement().executeUpdate("insert into apuestas(id_usuario, monto, tipo, id_comp, fecha, estado) values('"+id_user+"',"+plata+", 'Campeon', "+idcomp+", '2012-10-23', 'pendiente') ");
    ResultSet id_ap = mbd.getStatement().executeQuery("select MAX(id_apuesta) from apuestas");
    int id_apuesta=0;
    while (id_ap.next()){
        id_apuesta=id_ap.getInt(1);
    }
    mbd.getStatement().executeUpdate("insert into ap_campeon(id_apuesta, id_equipo) values("+id_apuesta+", "+idequipo+")");
    mbd.getStatement().executeUpdate("update usuarios set saldo=(saldo-"+plata+") where nick='"+nickuser+"' ");
    
    
%> 
 <script>
                    function hola(){window.location.href='index.jsp';}
                    function redir(){
                        document.write("Apuesta realizada con éxito...redireccionando :D ")
                        
                        setTimeout("hola()",3000);
                    }
                    redir();
                </script>