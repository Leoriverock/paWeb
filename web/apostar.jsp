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
        <%   if(session.getAttribute("username")!=null) {
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
                out.println("<form>");
                out.println("<h6>El monto de la apuesta es de: $"+monto+".</h6></br>");
                out.println("<h6>Su saldo será de: $"+(res.getDouble("saldo")-monto)+".</h6></br>");
                out.println("<h6>En caso de ganar, usted ganará $"+monto*divid+".</h6></br>");
                out.println("<h6>Desea realizar la apuesta?</h6>");
                nickuser = String.valueOf(session.getAttribute("username"));
                out.println("<a class=btn href=mandarABD.jsp?ap="+monto+"&idc="+id_c+"&ide="+id_e+"&user="+nickuser+" >Confirmar</a>");
                %>
                
                
                <% } else{
                       out.println("<h3>Saldo insuficiente para realizar apuesta!</h3>");
                       }
        }

        %>
            
    </div>
             <% }
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
