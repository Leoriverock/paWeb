

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="Clases.ManejadorBD"%>
<%@page import="java.util.ArrayList"%>
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
    <script type="text/javascript" src="js/jquery.min.js"></script> 
<script type="text/javascript" src="js/jquery.scrollTo-min.js"></script> 
<script type="text/javascript" src="js/jquery.localscroll-min.js"></script> 
<script type="text/javascript" src="js/init.js"></script> 

    <title>iBet</title>
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
    <div id="col" class="box">
   
           <div id="Contenido">

	</div>
	<div id="Contenido_main">
	<% if(session.getAttribute("username")!=null){ %>
		<div id="content"> 
            <div id="home" class="section">
				<div id="centrado2">
				<!--Marquesina-->
				<div class="marquee marqueeV">
					<p> <img src="imagenes/Portada1.png" alt="Portada1" /> </p>
					<p> <img src="imagenes/Portada2.png" alt="Portada2" /> </p>
					<p> <img src="imagenes/Portada3.png" alt="Portada3" /> </p>
					<p> <img src="imagenes/Portada4.png" alt="Portada4" /> </p>
				</div></div>
				<!--Fin Marquesina-->  
				<div id="centrado">
                <ul id="Menu">
                    <li><a href="#Ibet" class="Ibet"><span>Sobre Ibet</span></a></li>
                    <li><a href="#Competiciones" class="Competiciones"><span>Competiciones</span></a></li>
                    <li><a href="#Partidos" class="Partidos"><span>Partidos</span></a></li>
                    
                </ul>
				</div>
            </div>
            
           <!--Sobre ibet-->
            <div class="section" id="Ibet"> 
                <h1>Ibet</h1>
                <div class="half left">
                	<p><em>El procedimiento de apuesta consiste en un depósito de dinero o algún objeto de valor en función de un evento contingente, con el objetivo de obtener dinero o bienes adicionales.</em></p>
                	<ul class="list_bullet">
                        <li>Registro de usuarios</li>
                        <li>Deposito en monedero</li>
                        <li>Informacion de Partidos</li>
                        <li>Informacion de Ligas</li>
                        <li>Apuestas a resultado</li>
                        <li>Apuestas a resultado exacto</li>
                        <li>Apuestas a campeon</li>
                    </ul>
                </div>
                <div class="half right">
                    <div class="img_border img_nom">
                        <img src="imagenes/Estadio.jpg" alt="Imagen 01" />	
                    </div>
                    
                <p> Cada uno de los posibles resultados tiene asociados cuotas, factores o dividendos que indican cuántas veces se obtiene –en caso de ser ganador- el monto apostado.Los resultados que el jugador obtenga en Ibet no dependerán del azar, sino de los conocimientos que se tengan sobre el deporte y sus protagonistas.</p>
                </div>
                <a href="#home" class="home_btn">Inicio</a> 
            </div> 
            <!--Fin Sobre ibet-->
		
			<!--Competciones-->
            <div class="section" id="Competiciones"> 
                <h1>Competiciones</h1>
                <h3>Aqui usted podrá apostar por quién será el campeón de esta liga...</h3>
                         <form method="POST" action="DividendoCampeon.jsp.jsp">
                            <h4></h4>    
                                <table class="table table-bordered">
                                <%
                                //tabla con links a detalle de jugador
                                ManejadorBD mbd= ManejadorBD.getInstancia();

                                try{
                                    ResultSet liga= mbd.getStatement().executeQuery("select * from competiciones where tipo='Liga'");
                                    while(liga.next()){
                                        out.println("<tr>");
                                        out.println("<td><a href=DividendoCampeon.jsp?cod="+liga.getObject("id_competicion")+">"+liga.getObject("Nombre")+"</a></td>");
                                        out.println("</tr>");
                                    }
                                } catch(Exception ex){
                                    out.println("<h2>error en la consulta de jugadores</h2>");
                                }
                                %>
                            </table>
                         </form>
                <a href="#home" class="home_btn">home</a> 	
            </div> 
			<!--Fin Competciones-->
            
            <!--Partidos-->
			<div class="section" id="Partidos"> 
               	<h1>Partidos</h1>
              	
                <a href="#home" class="home_btn">home</a> 
            </div> 
            <!--Fin Partidos-->
        </div> <%}%>
    </div>
</div>
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
