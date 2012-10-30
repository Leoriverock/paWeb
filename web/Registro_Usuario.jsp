<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" import="Clases.*, java.lang.*"%>
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
    <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
                function verificar(login_usuario)
            {
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp=new XMLHttpRequest();
                }
                 xmlhttp.onreadystatechange=function()
                {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200)
                    {
                        document.getElementById("resultau").innerHTML=xmlhttp.responseText;
                    }
                }
                xmlhttp.open("GET","newjsp.jsp?q="+login_usuario,true);
                xmlhttp.send();
            }
            </script>
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
            <a href="#">Contacto</a>
        </div> <!-- /nav -->

    </div> <!-- /header -->
    
    <!-- Tray -->
    <div id="tray">

        <ul>
            <li><a href="index.jsp">Inicio</a></li> <!-- Active page -->
            <li id="tray-active" ><a href="VerCompeticiones.jsp">Competiciones</a></li>
            <li><a href="VerPartidos.jsp">Partidos</a></li>
            <li><a><div id="reloj">
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
                                
                                document.getElementById("reloj").innerHTML = '<font size="2" face="Arial"><B>' + horas+':'+minutos+':'+segundos+"\n "+dia+"/"+mes+"/"+anio;
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
        <%if(session.getAttribute("username")!=null){ %>
                                <ul class="nav pull-right">
                                    <li><a>Bienvenido: <%out.print(session.getAttribute("username")); %></a></li>
                                    <li><a href="Perfil_Usuario.jsp">Editar Perfil</a></li>
                                    <li><a href="Logout.jsp">Cerrar Sesion</a></li>
                                </ul>
                                <%}%>
        <!-- login -->
        <div id="login" class="box">
            
        </div> <!-- /login -->

    <hr class="noscreen" />
    
    </div> <!-- /tray -->
    <div id="col" class="box">
    <% if(session.getAttribute("username")==null){
                 if(request.getParameter("login_usuario") == null && 
                         request.getParameter("correo_usuario") == null && 
                         request.getParameter("contrasenia_usuario")== null &&
                         request.getParameter("r_contrasenia_usuario") == null &&
                         request.getParameter("sexo_usuario") == null &&
                         request.getParameter("pais_usuario") == null) {
                                         
              %>
           <fieldset>
             <legend><b>Registro de Usuario</b></legend>
             <FORM class="form-horizontal" id="formulario" name="formulario" method="POST" action="Validar.jsp" >
                 <table cellpadding="5" align="center" border="0">
                        <tr><td>
                                <table class="well">

                                        <tr >
                                        <td>Nombre de Login:</td>
                                        <td><input  class="inputNormal" type="text"  name="login_usuario" id="login_usuario">
                                        <div id="resultau">         </div>
                                        </tr> 

                                        <tr >
                                        <td>Nombre Completo:</td>
                                        <td><input class="inputNormal" type="text" name="nombre_usuario" id="email_usuario">
                                        
                                        </tr>
                                        <tr >
                                        <td>E-mail:</td>
                                        <td><input class="inputNormal" type="text" name="email_usuario" id="email_usuario">
                                        
                                        </tr>
                                        <tr >
                                        <td>Contraseña:</td>
                                        <td><input  class="inputNormal" type="text" name="contrasenia_usuario" id="contrasenia_usuario">
                                        </tr>

                                        <tr>
                                            <td>Repetir Contraseña:</td>
                                            <td><input type="text" class="inputNormal" name="r_contrasenia_usuario" id="r_contrasenia_usuario"  >
                                        </tr>
                                        <td>Telefono:</td>
                                        <td><input  class="inputNormal" type="text"  name="tel_usuario" id="tel_usuario">
                                        </tr> 
                                         <td>Direccion:</td>
                                        <td><input  class="inputNormal" type="text"  name="dir_usuario" id="dir_usuario">
                                        </tr> 
                                        <td>Documento:</td>
                                        <td><input  class="inputNormal" type="text"  name="doc_usuario" id="doc_usuario">
                                        </tr> 
                                        <tr ><td>Sexo:</td>
                                            <td><select name="sexo_usuario" id="sexo_usuario">
                                                <option value="seleccione" selected>*Seleccione*</option>
                                                <option value="Masculino">Masculino</option>
                                                <option value="Femenino">Femenino</option>
                                        </select></td></tr>

                                        <tr><td>Fecha de Nacim.:</td><td><input type="text" name="nacimiento_usuario" id="nacimiento_usuario"  maxlength="10">
                                            </tr>
                                        <tr><td>País:</td><td><input type="text" name="pais_usuario" id="pais_usuario"  maxlength="50"></td></tr>
                                        </table>
				</td></tr>
		<tr>
                    <td colspan="2">
                            <table align="center">
                                     <tr>	
                                        <td width="60"></td>
                                        <td>
                                            <button  class="btn btn-success" name="boton_confirmar" id="boton_confirmar"   type="submit">Confirmar</button>   
                                            
                                        </td>
                                    </tr>
                            </table>
                    </td>
                </tr>
            </table>
        </FORM>
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
   <%}
                                          }
                                            else{
                          %><script>alert("Ya ha iniciado una sesion, Intente mas tarde");
                            window.location.href='index.jsp';</script>
                      <% } %>
</body>
</html>
