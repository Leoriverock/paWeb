<%-- 
    Document   : GraficaTorta
    Created on : 29-oct-2012, 17:17:16
    Author     : claudio
--%>

<!--
You are free to copy and use this sample in accordance with the terms of the
Apache license (http://www.apache.org/licenses/LICENSE-2.0.html)
-->
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="Clases.*, java.lang.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>
      Google Visualization API Sample
    </title>
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
  <body style="font-family: Arial;border: 0 none;">
    <div id="visualization" style="width: 600px; height: 400px;"></div>
  </body>
</html>
