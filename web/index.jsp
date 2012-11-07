<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="Clases.*, java.lang.*"%>
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
        <style type="text/css">
			#container
			{
				overflow: hidden;
				width: 255px;
				height: 177px;
			}
			#container img
			{
				position: absolute;
				width: 255px;
				height: 177px;	
			}
		</style>
		<script type="text/javascript" language="javascript" src="jquery.js"></script>
		<script type="text/javascript" language="javascript">

			var deltaX = 11;
			var deltaT = 440;	
			var imageWidth = 2;

			$(document).ready (function ()
			{
				$("#container img").click (changeViewportImage);
				setTimeout("animate()", deltaT); //start animation
			});

			function changeViewportImage ()
			{
				$("#viewport img").remove ();
				$("#viewport").append ($(this).clone ());
			}

			function animate ()
			{
				var pos = parseInt ($("#container img").css("left"));
				//left -= deltaX;

				//if (left <= -imageWidth) //if first image is no longer visible
				//{
					pos = imageWidth;
					$("#container img:first").remove ().insertAfter("#container img:last").click (changeViewportImage);
				//}

				$("#container img").css("left", pos + "px");

				setTimeout ("animate()", deltaT); //continue animation
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
    
        
        <!-- Screenshot in browser (replace tmp/browser.gif) -->
        <div id="col-browser"><a>
               <marquee border="1px"><p height="10" width="255" ><B>Copa del Mundo - UEFA - Copa Santander Libertadores - Campeonato Uruguayo - Copa del Rey - Liga Italiana - Liga Espanola - Liga Inglesa  </B> </p></marquee>
               </a> 
               <div id="container">
			<p><img src="Ligas/Esp.png"/></p>
			<p><img src="Ligas/cham.png"/></p>
			<p><img src="Ligas/ing.png"/></p>
			<p><img src="Ligas/lib.png"/></p>
			<p><img src="Ligas/mun.png"/></p>
                        <p><img src="Ligas/uefa.png"/></p>
			<p><img src="Ligas/nis.png"/></p>
                        <p><img src="Ligas/rey.png"/></p>
		</div>
		
            </div> 
        
        <div id="col-text">

            <h2 id="slogan"><span></span>Bienvenidos a iBet</h2>
            
            <p>
                Lo invitamos a experimentar el nuevo mundo de apuestas deportivas en Internet.
                El lugar más creíble y confiable de apuestas deportivas en línea esta ahora abierto para usted!
            </p>
            <div class="dropdown">
            <div id="btns">
               <% if(session.getAttribute("username")==null){%> 
                                <a class="btn btn-success" href="Registro_Usuario.jsp">Registrarse<strong></strong></a>
				<a class= "btn dropdown-toggle" data-toggle="dropdown" href="#">Iniciar Sesion<strong class="caret"></strong></a>
					<div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
					  <form action="Login.jsp" method="POST">
						  <label>Usuario:</label><input type="Text" name="in_usuario"/>
						  <label>Contraseña:</label><input type="Password" name="pass_usuario"/>
                                                  <label class="checkbox">
                                                  <input type="checkbox"> Recordar
                                                  </label>
                                                  <label></label><input type="submit" class="btn" value="Ingresar"/>
                                                  <a href="#">Olvidaste la contraseña?</a>
                                        </form>
                                    </div>
                               <% } %>
            </div>
            </div>

        </div> <!-- /col-text -->
    
    </div> <!-- /col -->
    <div id="col-bottom"></div>
    
    <hr class="noscreen" />
    
    <!-- 3 columns -->
    <div id="cols3-top"></div>
    <div id="cols3" class="box">
    
        <!-- Apuestas -->
        <div class="col">

            <h3><a href="Apuestas.jsp">Apuestas</a></h3>
            
            <p class="nom t-center"><a href="Apuestas.jsp"><img src="imagenes/apuesta.png" alt="" /></a></p>

            <div class="col-text">

                <p>
                    En esta seccion se pondra en juego tus conocimientos sobre el deporte,
                    aqui podras:
                </p>
                
                <ul class="ul-01">
                    <li><a href="ListaPartidos.jsp">Apostar a Partidos</a></li>
                    <li><a href="ApostarResExacto.jsp">Apostar al resultado exacto de un Partido</a></li>
                    <li><a href="ListaLigas.jsp">Apostar al Campeón de una Liga</a></li>
                    <li><a href="ListarLigas.jsp">Apostar al Goleador de Liga</a></li>
                    <li>Realizar Pencas con sus Amigos</li>
                    <li><a href="VerApuestas.jsp">Ver Apuestas Realizadas</a></li>
                </ul>

            </div> <!-- /col-text -->

            <div class="col-more"><a href="Apuestas.jsp">Ver mas...</a></div>

        </div> <!-- /col -->

        <hr class="noscreen" />

        <!-- Competiciones -->
        <div class="col">

            <h3><a href="VerCompeticiones.jsp">Competiciones</a></h3>

            <p class="nom t-center"><a href="VerCompeticiones.jsp"><img src="imagenes/competicion.png" alt="" /></a></p>

            <div class="col-text">

                <p>Aqui podra tener a su alcance la informacion relevante a las competiciones disponibles</p>

                <ul class="ul-01">
                    <li>Equipos que participan</li>
                    <li>Ultimos Partidos</li>
                    <li>Tabla de posiciones</li>
                    <li>Jugadores</li>
                    <li>Goleadores</li>
                </ul>

            </div> <!-- /col-text -->

            <div class="col-more"><a href="VerCompeticiones.jsp">Ver mas...</a></div>

        </div> <!-- /col -->

        <hr class="noscreen" />

        <!-- partidos -->
        <div class="col last">

            <h3><a href="VerPartidos.jsp">Partidos</a></h3>

            <p class="nom t-center"><a href="VerPartidos.jsp"><img src="imagenes/partido.png" alt="" /></a></p>

            <div class="col-text">

                <p>Aqui estara disponible la informacion de partidos jugados y por jugar</p>

                <ul class="ul-01">
                    <li>Resultados</li>
                    <li>Dividendos</li>
                    <li>Goles</li>
                    <li>Tarjetas</li>
                    <li>Sustituciones</li>
                </ul>

            </div> <!-- /col-text -->

            <div class="col-more"><a href="VerPartidos.jsp">Ver mas...</a></div>

        </div> <!-- /col -->

        <hr class="noscreen" />
    
    </div> <!-- /cols3 -->
    <div id="cols3-bottom"></div>

    <!-- 2 columns -->
    <div id="cols2-top"></div>
    <div id="cols2-bottom"></div>

    <hr class="noscreen" />

    <!-- Footer -->
    <div id="footer">
        <p>
            <!--
            <img src="imagenes/wla.gif" />
            <img src="imagenes/loteria.jpg" />
            <img src="imagenes/labanca.jpg" />
            -->
        </p>
    </div> <!-- /footer -->

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
