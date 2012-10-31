<%-- 
    Document   : ApuestaPartido
    Created on : 02-oct-2012, 18:42:20
    Author     : Usaurio
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ManejadorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/main.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/style.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/Estilo.css" />
    <link rel="stylesheet" media="print" type="text/css" href="css/print.css" />
    <link rel="shortcut icon" href="imagenes/favicon.ico" type="image/x-icon" />

    <title>iBet</title>
   <script type="text/javascript">
        function registro(ip,so,cliente,fecha)
                    {
                        if (window.XMLHttpRequest)
                        {// code for IE7+, Firefox, Chrome, Opera, Safari
                            xmlhttp=new XMLHttpRequest();
                        }

                        xmlhttp.open("GET","prueba1.jsp?ip="+ip+"&so="+so+"&cliente="+cliente+"&fecha="+fecha,true);
                        xmlhttp.send(null);
                    }
        </script>
    <%
    ManejadorBD mbd = ManejadorBD.getInstancia();
    String ipCustom = request.getRemoteAddr();
    
    %>
</head>

<body>
     
<div id="main">
    
      <!-- Header -->
    <div id="header">

        <h1 id="logo"><a href="index.jsp" title="ibet apuestas deportivas"><img src="imagenes/logo.png" alt="" /></a></h1>
        <hr class="noscreen" />

        <!-- Navigation -->
        <div id="nav">
            <a id="nav-active" href="index.jsp">Inicio</a> <span>|</span>
            <a href="#">Acerca de iBet</a> <span>|</span>
            <a href="#">Soporte</a> <span>|</span>
            <a href="#">Contacto</a> <span>|</span>
              <%if(session.getAttribute("username")!=null){ %>
                                <div class="pull-right">
                                     <a id="nav-active" class="dropdown-toggle" data-toggle="dropdown" href="#">
                                     Bienvenido: <%out.print(session.getAttribute("username")); %></a>
                                     <ul class="dropdown-menu">
                                         <li><a href="Perfil_Usuario.jsp">Editar Perfil</a></li> 
                                         <li><a href="Logout.jsp">Cerrar Sesion</a></li>
                                     </ul>
                                </div>
                                <%}%>   
            
        </div> <!-- /nav -->
       
    </div> <!-- /header -->
    
    <!-- Tray -->
    <div id="tray">

        <ul>
            <li id="tray-active" ><a href="index.jsp">Inicio</a></li> <!-- Active page -->
            <%if(session.getAttribute("username")!=null){ %><li><a href="monedero.jsp">Usuario</a></li><%}%>
            <li><a href="VerCompeticiones.jsp">Competiciones</a></li>
            <li><a href="VerPartidos.jsp">Partidos</a></li>
            <li class="pull-right"><a><div id="reloj">
                                <script language="javascript">
                                function muestraReloj() {
                                var fechaHora = new Date();
                                var hora_resta = parseInt(document.getElementById("h-resta").value);
                                var min_resta = parseInt(document.getElementById("min-resta").value);
                                var dia_resta = parseInt(document.getElementById("d-resta").value);
                                var mes_resta = parseInt(document.getElementById("mes-resta").value);
                                var anio_resta = parseInt(document.getElementById("a-resta").value);
                                
                                var horas = parseInt(fechaHora.getHours()+hora_resta);
                                var minutos = parseInt(fechaHora.getMinutes()+min_resta);
                                var segundos = parseInt(fechaHora.getSeconds());
                                var dia = parseInt(fechaHora.getDate()+dia_resta);
                                var mes = parseInt(fechaHora.getMonth()+1 + mes_resta);
                                var anio = parseInt(fechaHora.getYear()+1900+anio_resta);

                                
                                if(minutos<0)
                                {
                                    minutos=minutos+60;
                                    horas=horas-1;
                                }
                                if(horas<0)
                                {
                                    horas= horas+24;
                                    dia=dia-1;
                                }
                                if(dia<1)
                                {
                                    mes=mes-1;
                                    if(mes==1 || mes==3 || mes==5 || mes==7 || mes==8 || mes==10 || mes==12)
                                    {
                                        dia=dia+31;
                                    }
                                    if(mes==2)
                                    {
                                        dia=dia+29;
                                    }
                                    if(mes==4 || mes==6 || mes==9 || mes==11)
                                    {
                                        dia=dia+30;
                                    }
                                }
                                if(mes<1)
                                {
                                    mes=mes+12;
                                    anio=anio-1;
                                }

 
                                if(horas < 10) { horas = '0' + horas; }
                                if(minutos < 10) { minutos = '0' + minutos; }
                                if(segundos < 10) { segundos = '0' + segundos; }
                                
                                document.getElementById("reloj").innerHTML = '<font size="2" face="sans-serif">'+horas+':'+minutos+':'+segundos+"\n"+dia+"/"+mes+"/"+anio;
                                }

                                window.onload = function() {
                                  setInterval(muestraReloj, 1000);
                                } 
                                </script>
                                </div></a></li>                    
            <!--
            <li><a href="#">Equipos</a></li>
            <li><a href="#">Jugadores</a></li>
            -->
        </ul>
       
            
 
    <hr class="noscreen" />
    </div> <!-- /tray -->

    <!-- Promo -->
    <div id="col-top"></div>
    <div id="col" class="box">
    <h3>Apuestas Partido</h3>
        <table class="table table-striped" >
            <%
            
            ResultSet apuestap = mbd.getStatement().executeQuery("select * from apuestas a, partidos p, usuarios u, ap_partidos ap,"
                    +" equipos e1, equipos e2 where a.id_apuesta=ap.id_apuesta and p.id_partido=ap.id_partido and "
                    +"u.nick='"+session.getAttribute("username")+"' and u.id_user=a.id_usuario and p.equipolocal=e1.id_equipos"
                    +" and p.equipovisita=e2.id_equipos order by a.fecha desc");
            out.println("<tr>");
            out.println("<td><a>Evento</a></td>");
            out.println("<td><a>Tipo Apuesta</a></td>");
            out.println("<td><a>Realizada</a></td>");
            out.println("<td><a>Apuesta por</a></td>");
            out.println("<td><a>Apostado</a></td>");
            out.println("<td><a>Dividendo</a></td>");
            out.println("<td><a>Ganará</a></td>");
            out.println("<td><a>Estado</a></td>");
            out.println("</tr>");   
            
            while(apuestap.next()){
                out.println("<tr>");
                out.println("<td><a>"+apuestap.getObject("e1.nombre")+" vs "+apuestap.getObject("e2.nombre")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("a.tipo")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("a.fecha")+"</a></td>");
                out.println("<td><a>"+apuestap.getObject("ap.opcion")+"</a></td>");
                out.println("<td><a> $ "+apuestap.getObject("a.monto")+"</a></td>");
                if (apuestap.getString("ap.opcion").equals("local")){
                    out.println("<td><a>"+apuestap.getDouble("p.divlocal") +"</a></td>");
                    out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divlocal") +"</a></td>");
                    } else if (apuestap.getString("ap.opcion").equals("empate")){
                            out.println("<td><a>"+apuestap.getDouble("p.divempate") +"</a></td>");
                            out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divempate") +"</a></td>");
                        } else if (apuestap.getString("ap.opcion").equals("visitante")){
                            out.println("<td><a>"+apuestap.getInt("p.divvisita") +"</a></td>");
                            out.println("<td><a> $ "+apuestap.getInt("a.monto")*apuestap.getDouble("p.divvisita") +"</a></td>");
                        }
                out.println("<td><a>"+apuestap.getObject("a.estado") +"</a></td>");
                out.println("</tr>");
            
            }
            %>
        </table>
        
        <h3>Apuestas Resultado exacto</h3>
        <table class="table table-striped" >
            <%
            
            ResultSet res_ex = mbd.getStatement().executeQuery("select * from apuestas a, partidos p, usuarios u, ap_res_exacto are,"
                    +" equipos e1, equipos e2 where a.id_apuesta=are.id_apuesta and p.id_partido=are.id_partido and "
                    +"u.nick='"+session.getAttribute("username")+"' and u.id_user=a.id_usuario and p.equipolocal=e1.id_equipos"
                    +" and p.equipovisita=e2.id_equipos order by a.fecha desc");
            out.println("<tr>");
            out.println("<td><a>Evento</a></td>");
            out.println("<td><a>Tipo Apuesta</a></td>");
            out.println("<td><a>Realizada</a></td>");
            out.println("<td><a>Apuesta por</a></td>");
            out.println("<td><a>Apostado</a></td>");
            out.println("<td><a>Dividendo</a></td>");
            out.println("<td><a>Ganará</a></td>");
            out.println("<td><a>Estado</a></td>");
            out.println("</tr>");   
            
            while(res_ex.next()){
                out.println("<tr>");
                out.println("<td><a>"+res_ex.getObject("e1.nombre")+" vs "+res_ex.getObject("e2.nombre")+"</a></td>");
                out.println("<td><a>"+res_ex.getObject("a.tipo")+"</a></td>");
                out.println("<td><a>"+res_ex.getObject("a.fecha")+"</a></td>");
                out.println("<td><a>"+res_ex.getObject("are.goles_local")+" - "+res_ex.getObject("are.goles_visita")+"</a></td>");
                out.println("<td><a> $ "+res_ex.getObject("a.monto")+"</a></td>");
                    out.println("<td><a>"+res_ex.getDouble("p.div_exacto") +"</a></td>");
                    out.println("<td><a> $ "+res_ex.getInt("a.monto")*res_ex.getDouble("p.div_exacto") +"</a></td>");
                out.println("<td><a>"+res_ex.getObject("a.estado") +"</a></td>");
                out.println("</tr>");
            
            }
            %>
        </table>
        
        
        <h3>Apuestas Resultado exacto</h3>
        <table class="table table-striped">
            <%
            
            ResultSet gol = mbd.getStatement().executeQuery("select * from apuestas a, jugadores j, competiciones c, usuarios u, ap_goleador_comp ag "
                    +" where a.id_apuesta=ag.id_apuesta and c.id_competicion=a.id_comp and j.id_jugador=ag.id_jugador and "
                    +" u.nick='"+session.getAttribute("username")+"' and u.id_user=a.id_usuario order by a.fecha desc");
            out.println("<tr>");
            out.println("<td><a>Evento</a></td>");
            out.println("<td><a>Tipo Apuesta</a></td>");
            out.println("<td><a>Realizada</a></td>");
            out.println("<td><a>Apuesta por</a></td>");
            out.println("<td><a>Apostado</a></td>");
            out.println("<td><a>Dividendo</a></td>");
            out.println("<td><a>Ganará</a></td>");
            out.println("<td><a>Estado</a></td>");
            out.println("</tr>");   
            
            while(gol.next()){
                out.println("<tr>");
                out.println("<td><a>"+gol.getObject("c.nombre") +"</a></td>");
                out.println("<td><a>"+gol.getObject("a.tipo")+"</a></td>");
                out.println("<td><a>"+gol.getObject("a.fecha")+"</a></td>");
                out.println("<td><a>"+gol.getObject("j.nombre") +"</a></td>");
                out.println("<td><a> $ "+gol.getObject("a.monto")+"</a></td>");
                    out.println("<td><a>"+gol.getDouble("ag.div_jug") +"</a></td>");
                    out.println("<td><a> $ "+gol.getInt("a.monto")*gol.getDouble("ag.div_jug") +"</a></td>");
                out.println("<td><a>"+gol.getObject("a.estado") +"</a></td>");
                out.println("</tr>");
            
            }
            %>
        </table>

</div> <!-- /main -->
<%
List lista = new ArrayList();
lista = ManejadorBD.getInstancia().ObtenerFechaHora();

int dia_resta=Integer.valueOf(lista.get(0).toString());
int mes_resta=Integer.valueOf(lista.get(1).toString());
int anio_resta=Integer.valueOf(lista.get(2).toString());
int hora_resta=Integer.valueOf(lista.get(3).toString());
int min_resta=Integer.valueOf(lista.get(4).toString());
 %>    
<input type="hidden" id="h-resta" value="<%=hora_resta%>" />
<input type="hidden" id="min-resta" value="<%=min_resta%>" />
<input type="hidden" id="d-resta" value="<%=dia_resta%>" />
<input type="hidden" id="mes-resta" value="<%=mes_resta%>" />
<input type="hidden" id="a-resta" value="<%=anio_resta%>" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="funciones.js"></script>
<script type="text/javascript">
    
    var ip2= '0';
    var so2= 'Desconocido';
    var cliente2= 'Desconocido';
    //var fecha='2012-12-12';
    ip2='<%=ipCustom%>';    
    
  var is_mozilla= navigator.userAgent.toLowerCase().indexOf('firefox/') > -1;
if (is_mozilla) cliente2='Mozilla'; 
   
   var is_chrome= navigator.userAgent.toLowerCase().indexOf('chrome/') > -1;
if (is_chrome) cliente2='Chrome';

var ie=(document.all)? true:false;
if (ie) cliente2='Internet Explorer';

  
     
var fechaHora = new Date();
                                var hora_resta = parseInt(document.getElementById("h-resta").value);
                                var min_resta = parseInt(document.getElementById("min-resta").value);
                                var dia_resta = parseInt(document.getElementById("d-resta").value);
                                var mes_resta = parseInt(document.getElementById("mes-resta").value);
                                var anio_resta = parseInt(document.getElementById("a-resta").value);
                                
                                var horas = parseInt(fechaHora.getHours()+hora_resta);
                                var minutos = parseInt(fechaHora.getMinutes()+min_resta);
                                var segundos = parseInt(fechaHora.getSeconds());
                                var dia = parseInt(fechaHora.getDate()+dia_resta);
                                var mes = parseInt(fechaHora.getMonth()+1 + mes_resta);
                                var anio = parseInt(fechaHora.getYear()+1900+anio_resta);

                                
                                if(minutos<0)
                                {
                                    minutos=minutos+60;
                                    horas=horas-1;
                                }
                                if(horas<0)
                                {
                                    horas= horas+24;
                                    dia=dia-1;
                                }
                                if(dia<1)
                                {
                                    mes=mes-1;
                                    if(mes==1 || mes==3 || mes==5 || mes==7 || mes==8 || mes==10 || mes==12)
                                    {
                                        dia=dia+31;
                                    }
                                    if(mes==2)
                                    {
                                        dia=dia+29;
                                    }
                                    if(mes==4 || mes==6 || mes==9 || mes==11)
                                    {
                                        dia=dia+30;
                                    }
                                }
                                if(mes<1)
                                {
                                    mes=mes+12;
                                    anio=anio-1;
                                }

 
                                if(horas < 10) { horas = '0' + horas; }
                                if(minutos < 10) { minutos = '0' + minutos; }
                                if(segundos < 10) { segundos = '0' + segundos; }


if(mes<10)
{
     if(dia<10)
     {
           var fecha=''+anio+'-0'+mes+'-0'+dia+'';   
     }
     else
     {
           var fecha=''+anio+'-0'+mes+'-'+dia+''; 
     }
}
else
{
    if(dia<10)
    {
        var fecha=''+anio+'-'+mes+'-0'+dia+'';             
    }
    else
        {
            var fecha=''+anio+'-'+mes+'-'+dia+''; 
        }
}
 

var navInfo = window.navigator.appVersion.toLowerCase();        
                
        
	if(navInfo.indexOf('win') != -1)
	{        
            so2='Windows';
                       
            
	}
	else if(navInfo.indexOf('linux') != -1)
	{
		so2='Linux';
	}
	else if(navInfo.indexOf('mac') != -1)
	{
		so2='Mac';
	}
        

registro(ip2,so2,cliente2,fecha); 

    
</script>
</body>
</html>
