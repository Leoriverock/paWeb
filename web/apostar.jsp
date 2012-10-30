<%-- 
    Document   : apostar
    Created on : 03-oct-2012, 6:59:42
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <link href="Estilo.css" rel="stylesheet">
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
			
			<!--Barra de Menu-->	
				<div class="navbar-inner">
					<div class="container">
						<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</a>
					<a class="brand">Apuesta</a>
					<div class="nav-collapse">
				<ul class="nav">
					<li class="active"><a href="index.jsp"><i class="icon-home icon-white"></i>Inicio</a></li>
					  <li><a href="Perfil_Usuario.jsp">Usuario</a></li>
					  <li><a href="Competiciones.jsp">Competiciones</a></li>
					  <li><a href="#">Partidos</a></li>
                                          <li class="dropdown" id="menu1">
                                            <a class="dropdown-toggle" data-toggle="dropdown" href="#menu1">
                                              Apuestas
                                              <b class="caret"></b>
                                            </a>
                                            <ul class="dropdown-menu">
                                              <li><a href="ListaPartidos.jsp">Resultado de Partido</a></li>
                                              <li><a href="ListaLigas.jsp">Campeón de Liga</a></li>
                                            </ul>
                                          </li>
                                 </ul>
                                <%if(session.getAttribute("username")!=null){ %>
                                <ul class="nav pull-right">
                                    <li><a>Bienvenido: <%out.print(session.getAttribute("username")); %></a></li>
                                    <li><a href="Perfil_Usuario.jsp">Editar Perfil</a></li>
                                    <li><a href="Logout.jsp">Cerrar Sesion</a></li>
                                </ul>
                                <%}%>  
				<% if(session.getAttribute("username")==null){%> 
                                <ul class="nav pull-right">
				  <li><a href="Registro_Usuario.jsp">Registrarse</a></li>
					<li class="divider-vertical"></li>
					<li class="dropdown">
					<a class="dropdown-toggle" href="#" data-toggle="dropdown">Iniciar Sesion <strong class="caret"></strong></a>
					<div class="dropdown-menu" style="padding: 15px; padding-bottom: 0px;">
					  <form action="Login.jsp" method="POST">
						  <label>Usuario:</label><input type="Text" name="nombre_usuario">
						  <label>Contraseña:</label><input type="Password" name="pass_usuario">
						  <input type="submit" class="btn" value="Ingresar">
					<a href="#">Olvidaste la contraseña?</a>
                                        </form>
				</div> <% } %>
				
                               </div>
			</div>
		  </div>
		</div>
      <!--Contenedor-->                          
      <div class="container-fluid">
        <div class="row-fluid">
            <!--Menu Costado-->
            <div class="span2">
               <div class="costado">
                <table class="table table-bordered">   
                <tr><td><a href =VerDetalleEquipos.jsp>VerDetalleEquipos</a></td></tr>
                <tr><td><a href =DetalleJugadores.jsp>VerDetalleJugadores</a></td></tr>
                <tr><td><a href =monedero.jsp>Monedero</a></td></tr>
                <tr><td><div id="reloj">
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
                                </div>
                    </td></tr>
                </table>
               </div>
               </div>
            <!--Fin Menu Costado-->
            <!--Contenido-->    
            <div class="span10">
                    <div class="centro">
                        <%
        String nickuser="";
        String mont = request.getParameter("monto");
        double monto = Double.parseDouble(mont);
        String id_c = request.getParameter("comp");
        String id_e = request.getParameter("eq");
        String dvi = request.getParameter("dvd");
        double divid = Double.parseDouble(dvi);
        ManejadorBD mbd= ManejadorBD.getInstancia();
        ResultSet res= mbd.getStatement().executeQuery("select * from usuarios where nick='"+session.getAttribute("username")+"'");
        
        if (res.next()){
            if (res.getDouble("saldo") >= monto){
                
                out.println("<h3>El monto de la apuesta es de: $"+monto+".</h3></br>");
                out.println("<h3>Su saldo será de: $"+(res.getDouble("saldo")-monto)+".</h3></br>");
                out.println("<h3>En caso de ganar, usted ganará $"+monto*divid+".</h3></br>");
                out.println("<h3>Desea realizar la apuesta?</h3>");
                nickuser = String.valueOf(session.getAttribute("username"));
                out.println("<a href=mandarABD.jsp?ap="+monto+"&idc="+id_c+"&ide="+id_e+"&user="+nickuser+" >Confirmar</a>");
                %>
                
                
                <% } else{
                       out.println("<h3>Saldo insuficiente para realizar apuesta!</h3>");
                       }
        }

        %>
                        
                  </div>                           
                 </div> 
            </div>
          </div>
         <!--Contenido-->
      
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
