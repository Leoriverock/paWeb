<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<!--Redireccion automatica cuando inicio sesion-->


<%
    String apuesta= request.getParameter("monto");
    int monto=Integer.parseInt(apuesta);

    String id_partido= request.getParameter("partido");
    int id_p=Integer.parseInt(id_partido);
    
    String reslt = request.getParameter("resultado");
    
    String res="algo";
       if (reslt.equals("1")){
           res="local";
       } else if (reslt.equals("x")){
           res="empate";
         } else if (reslt.equals("2")){
                res="visitante";
            } else {res=reslt;}

    ManejadorBD mbd = ManejadorBD.getInstancia();   
    
    
    
        
       ResultSet user=mbd.getStatement().executeQuery("select * from usuarios where nick='"+session.getAttribute("username")+"'");
       user.next();
       int id_user=user.getInt("id_user");
       
       ResultSet partido= mbd.getStatement().executeQuery("select * from partidos where id_partido="+id_p+"");
       partido.next();
       int id_c=partido.getInt("id_comp");
       
       mbd.getStatement().executeUpdate("insert into apuestas(id_usuario, monto, tipo, id_comp, fecha, estado) values("+id_user+","+monto+", 'partido',"+id_c+",'2012-10-5','pendiente')");
       ResultSet id_ap = mbd.getStatement().executeQuery("select MAX(id_apuesta) from apuestas");
       int id_apuest=0;
       id_ap.next();
       
       id_apuest = id_ap.getInt("max(id_apuesta)");
       System.out.println("id_ap="+id_apuest+" resultado="+res+" montoap="+monto+" nick="+session.getAttribute("username"));
       //id_apuest=id_ap.getInt(0);
       
       
       mbd.getStatement().executeUpdate("insert into ap_partidos(id_partido, opcion, id_apuesta) values("+id_c+", '"+res+"',"+id_apuest+")");
       mbd.getStatement().executeUpdate("update usuarios set saldo=(saldo-"+monto+") where nick='"+session.getAttribute("username")+"' ");
    
                    %>
                
                <script>
                    function hola(){window.location.href='index.jsp';}
                    function redir(){
                        document.write("Apuesta realizada con éxito...redireccionando :D ")
                        
                        setTimeout("hola()",3000);
                    }
                    redir();
                </script>
