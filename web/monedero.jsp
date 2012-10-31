<%-- 
    Document   : monedero
    Created on : 25-sep-2012, 21:41:39
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
    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/Estilo.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="css/style.css" />
    <link rel="stylesheet" media="print" type="text/css" href="css/print.css" />
    <link rel="shortcut icon" href="imagenes/favicon.ico" type="image/x-icon" />

    <title>iBet</title>
    
    <%
    ManejadorBD mbd= ManejadorBD.getInstancia();
    String nick;
    nick=String.valueOf(session.getAttribute("username"));    
    double perdida=1000;
    double ganada=1000; 
    double ganadaesp=1000; 
    int usuario;
    usuario=mbd.BuscarUsuarioId(nick);
    perdida=mbd.GraficaPerdidas(usuario); 
    ganada=mbd.GRaficarGanadasTotal(usuario);
    ganadaesp=mbd.GRaficarGanadasTotalEsp(usuario);                
    %>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['corechart']});
    </script>
    <script type="text/javascript">
      function drawVisualization() {
        // Create and populate the data table.
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Grafica'],
          ['Ganancia Real', <%=ganada%>],
          ['Perdidas', <%=perdida%>],
          ['Ganancia Esp', <%=ganadaesp%>],
        ]);
      
        // Create and draw the visualization.
        new google.visualization.PieChart(document.getElementById('visualization')).
            draw(data, {title:"Grafica"});
      }
      

      google.setOnLoadCallback(drawVisualization);
    </script>
    </head>
    
<body>
    <% if(session.getAttribute("username")==null){ %>
    <div class="alert alert-error">
        <span>Error: </span>debe autenticarse primero.
    </div>
   <% }%>
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
            <li  ><a href="index.jsp">Inicio</a></li> <!-- Active page -->
            <%if(session.getAttribute("username")!=null){ %><li id="tray-active"><a href="monedero.jsp">Usuario</a></li><%}%>
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
     <div id="col" class="box">
   
           <h4>En este espacio usted podra aumentar el saldo de su monedero</h1>
                    <form class="well" action="saldo.jsp" method="POST">
                        <fieldset class="Inicio de Sesion">
                            <legend><b>Monedero</b></legend>

                         <table>         
                             <tr>
                                 <td>Saldo:</td>
                                 <td>
                                    <%
                                    ResultSet saldo = mbd.getStatement().executeQuery("select saldo from usuarios where nick='"+session.getAttribute("username")+"'"); 
                                    while(saldo.next()){
                                    out.println(saldo.getObject("saldo"));
                                    }
                                    %>
                                 </td>
                             </tr> 
                             <tr>
                                 <td>Agregar $ </td>
                                 <td><input type="Text" name="agregar"></td>
                                 <tr>
                                     <td><input type="submit" class="btn btn-success" value="Acreditar"></td>
                                     <td>&nbsp;&nbsp;<a href="#myModal" role="button" class="btn btn-info" data-toggle="modal">Graficar</a></td>
                                     <!-- Modal -->
                                    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h3 id="myModalLabel">Grafica</h3>
                                        </div>
                                        <div class="modal-body">
                                        <p>Monedero</p>
                                        <div id="visualization" style="width: 600px; height: 400px;"></div>
                                        </div>
                                        <div class="modal-footer">
                                        <button class="btn btn-success" data-dismiss="modal" aria-hidden="true">Cerrar</button>
                                        </div>
                                    </div>
                                </tr>
                         </table>  
                       </fieldset>
                    </form>
    </div>
      
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
        
    </body>
</html>
