package Clases;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
      
  
public class ManejadorBD {
    private final static String driver = "com.mysql.jdbc.Driver";
    private final static String bd = "jdbc:mysql://192.168.56.101:3306/grupo2";
    private final static String usuario = "grupo2";
    private final static String password = "pa2012";
    
    private Connection conexion;
    private java.sql.Statement st;
    private static ManejadorBD instancia = null;
    
    public static ManejadorBD getInstancia(){
        if(instancia == null){
            instancia = new ManejadorBD();
        }
        return instancia;
    }
    
    private ManejadorBD() {
        try{
            Class.forName(driver);
            conexion = DriverManager.getConnection(bd, usuario, password);
            st = conexion.createStatement();
            System.out.println("Conexion exitosa");
        }
        catch(Exception ex){
            System.out.println("Error de conexion: "+ex.toString());
        }
    }
    
    public java.sql.Statement getStatement(){
        return st;
    }
   public ResultSet VerDetalleCompeticion(){
        try {
            ResultSet rs = st.executeQuery("SELECT * FROM competiciones");
             return rs;
        } catch (SQLException ex) {
            return null;
        }
    }
    //Ver Detalle Equipos, muestra lista de equipos
   public ResultSet VerDetalleEquipos(){
        try {
            ResultSet rs = st.executeQuery("SELECT * FROM equipos");
             return rs;
        } catch (SQLException ex) {
            return null;
        }
    }
    //Ver jugadores de equipo
   public ResultSet VerJugadoresEquipo(int id){
       try {
            ResultSet rs = st.executeQuery("SELECT * FROM jugadores_equipos, jugadores where equipo="+id+" and id_jugador=jugador");
             return rs;
        } catch (SQLException ex) {
            return null;
        }
   }
   //Ver Detalle Equipo, muestra informacion de un equipo seleccionado
   public ResultSet VerDetalleEquipo(int id){
        try {
            ResultSet rs = st.executeQuery("SELECT * FROM equipos WHERE id_equipos="+id+"");
            return rs;
        } catch (SQLException ex) {
            return null;
        }
   }
   public ResultSet login(String username){
        try {
            ResultSet rs = st.executeQuery("SELECT * from usuarios where nick = '"+username+"'");
            return rs;
        } catch (SQLException ex) {
            return null;
        }
   }
   public void registroUsuario(String username, String nombre, String correo, String password,String tel,String dir,String doc, String sexo, String pais){
         try {
            st.executeUpdate("insert into usuarios (nick, nombre, correo, password, telefono, direccion, nro_documento, sexo, pais) values ('"+username+"','"+nombre+"','"+correo+"','"+password+"','"+tel+"','"+dir+"','"+doc+"','"+sexo+"','"+pais+"')");
            
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
    }
   public void EditarRegistro( String dir, String pais, String tel, String nombre){
        try {
            st.executeQuery("UPDATE usuarios SET direccion = '"+dir+"', pais = '"+pais+"', tel = '"+tel+"'  WHERE nick ='"+nombre+"' ");
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
   }
   public List ObtenerFechaHora()
    {
        ResultSet res;
        List Lista= new ArrayList();
         try {
            res = st.executeQuery("select * from fecha where Id=1");
            while(res.next())
            {         
                Lista.add(res.getObject(1));
                Lista.add(res.getObject(2));
                Lista.add(res.getObject(3));
                Lista.add(res.getObject(4));
                Lista.add(res.getObject(5));              
            }
            return Lista;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return null;
        }
         
    }
   
     public ResultSet consultarUsuario (String nombre){
       ResultSet rs; 
        try {
            rs = st.executeQuery("select nick from usuarios where nick = '"+nombre+"'");
             return rs;
              
        } catch (SQLException ex) {
            
            return null;
        }
       
   }
     public ResultSet VerPartido(){
     ResultSet rs;
        try {
            rs = st.executeQuery("SELECT * FROM partidos");
            return rs;
        } catch (SQLException ex) {
           return null;
        }
     }
     public double GraficaPerdidas(Integer id_usuario)
    {
        ResultSet res;
        double perdida=0;
        double obtenida=0;
         try {
            res = st.executeQuery("select monto from apuestas,usuarios where usuarios.id_user=apuestas.id_usuario and estado='perdida' and id_usuario="+id_usuario+"");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                perdida=perdida+obtenida;
            }
            return perdida;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
    }
     
      public double GraficaGanadasGoleador(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,div_jug from apuestas,usuarios,ap_goleador_comp where usuarios.id_user=apuestas.id_usuario and apuestas.estado='ganada'and apuestas.id_apuesta=ap_goleador_comp.id_apuesta and usuarios.id_user="+id_usuario+"");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      
      public double GRaficarGanadasPartido(Integer id_usuario)
      {
          double local=0;
          double empate=0;
          double visitante=0;
          double total=0;
          local=this.GraficarSumLocalPartido(id_usuario);
          empate=this.GraficarSumEmpatePartido(id_usuario);
          visitante=this.GraficarSumVisitantePartido(id_usuario);
          total=local+empate+visitante;
          return total;
      }
      
      public double GRaficarGanadasTotal(Integer id_usuario)
      {
          double partido=0;
          double resultadoexacto=0;
          double graficacampeon=0;
          double goleador=0;
          double total=0;
          partido=this.GRaficarGanadasPartido(id_usuario);
          resultadoexacto=this.GraficaGanadaResultadoExacto(id_usuario);
          graficacampeon=this.GraficaCampeon(id_usuario);
          goleador=this.GraficaGanadasGoleador(id_usuario);
          total=partido+resultadoexacto+graficacampeon+goleador;
          return total;
      }
      
      public double GraficarSumLocalPartido(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivLocal from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='ganada' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='local'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      public double GraficarSumEmpatePartido(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivEmpate from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='ganada' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='empate'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      public double GraficarSumVisitantePartido(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivVisita from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='ganada' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='visitante'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      
      public double GraficaGanadaResultadoExacto(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,div_exacto from apuestas,usuarios,ap_res_exacto,partidos where usuarios.id_user=apuestas.id_usuario and estado='ganada' and id_usuario="+id_usuario+" and ap_res_exacto.id_apuesta=apuestas.id_apuesta and ap_res_exacto.id_partido=partidos.id_partido");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
    }
      public double GraficaCampeon(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,dividendo from apuestas,usuarios,ap_campeon,liga_equipo where usuarios.id_user=apuestas.id_usuario and estado='ganada' and id_usuario="+id_usuario+" and apuestas.id_apuesta=ap_campeon.id_apuesta and ap_campeon.id_equipo=liga_equipo.id_equipo and apuestas.id_comp=liga_equipo.id_liga");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
    }
      
      ////////////////////////////
      public double GraficaGanadasGoleadorEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,div_jug from apuestas,usuarios,ap_goleador_comp where usuarios.id_user=apuestas.id_usuario and apuestas.estado='pendiente'and apuestas.id_apuesta=ap_goleador_comp.id_apuesta and usuarios.id_user="+id_usuario+"");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      
      public double GRaficarGanadasPartidoEsp(Integer id_usuario)
      {
          double local=0;
          double empate=0;
          double visitante=0;
          double total=0;
          local=this.GraficarSumLocalPartido(id_usuario);
          empate=this.GraficarSumEmpatePartido(id_usuario);
          visitante=this.GraficarSumVisitantePartido(id_usuario);
          total=local+empate+visitante;
          return total;
      }
      
      public double GRaficarGanadasTotalEsp(Integer id_usuario)
      {
          double partido=0;
          double resultadoexacto=0;
          double graficacampeon=0;
          double goleador=0;
          double total=0;
          partido=this.GRaficarGanadasPartidoEsp(id_usuario);
          resultadoexacto=this.GraficaGanadaResultadoExactoEsp(id_usuario);
          graficacampeon=this.GraficaCampeonEsp(id_usuario);
          goleador=this.GraficaGanadasGoleadorEsp(id_usuario);
          total=partido+resultadoexacto+graficacampeon+goleador;
          return total;
      }
      
      public double GraficarSumLocalPartidoEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivLocal from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='pendiente' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='local'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      public double GraficarSumEmpatePartidoEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivEmpate from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='pendiente' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='empate'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      public double GraficarSumVisitantePartidoEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,DivVisita from apuestas,usuarios,ap_partidos,partidos where usuarios.id_user=apuestas.id_usuario and apuestas.estado='pendiente' and usuarios.id_user="+id_usuario+" and ap_partidos.id_apuesta=apuestas.id_apuesta and ap_partidos.id_partido=partidos.id_partido and ap_partidos.opcion='visitante'");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
         
    }
      
      public double GraficaGanadaResultadoExactoEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,div_exacto from apuestas,usuarios,ap_res_exacto,partidos where usuarios.id_user=apuestas.id_usuario and estado='pendiente' and id_usuario="+id_usuario+" and ap_res_exacto.id_apuesta=apuestas.id_apuesta and ap_res_exacto.id_partido=partidos.id_partido");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
    }
      public double GraficaCampeonEsp(Integer id_usuario)
    {
        ResultSet res;
        double ganada=0;
        double obtenida=0;
        double ganancia=0;
        double div=2;
         try {
            res = st.executeQuery("select monto,dividendo from apuestas,usuarios,ap_campeon,liga_equipo where usuarios.id_user=apuestas.id_usuario and estado='pendiente' and id_usuario="+id_usuario+" and apuestas.id_apuesta=ap_campeon.id_apuesta and ap_campeon.id_equipo=liga_equipo.id_equipo and apuestas.id_comp=liga_equipo.id_liga");
            while(res.next())
            { 
                obtenida=Double.valueOf(String.valueOf(res.getObject(1)));
                div=Double.valueOf(String.valueOf(res.getObject(2)));
                ganancia=obtenida*div;
                ganancia=ganancia-obtenida;
                ganada=ganada+ganancia;
            }
            return ganada;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return 0;
        }
         
    }
      
      public List GraficarEvolucionToda(Integer usuario)
    {
        
        ResultSet res;
        List Lista= new ArrayList();
         try {
            res = st.executeQuery("select monto,fecha from usuario_monedero where id_usuario"+usuario+" order by fecha");
            while(res.next())
            {         
                Lista.add(res.getObject(1));
                Lista.add(res.getObject(2));             
            }
            return Lista;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return null;
        }
         
    }
      
      public List GraficarEvolucionMin(Integer usuario,String fechamin)
    {
        
        ResultSet res;
        List Lista= new ArrayList();
         try {
            res = st.executeQuery("select monto,fecha from usuario_monedero where id_usuario="+usuario+" and fecha>=('"+fechamin+"') order by fecha");
            while(res.next())
            {         
                Lista.add(res.getObject(1));
                Lista.add(res.getObject(2));             
            }
            return Lista;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return null;
        }
         
    }
      
      public List GraficarEvolucion(Integer usuario,String fechamin)
    {
        
        ResultSet res;
        double suma=0; 
        List Devolucion= new ArrayList();
        List ListaTotal= new ArrayList();
        List ListaMin= new ArrayList();
        ListaTotal=this.GraficarEvolucionToda(usuario);
        ListaMin=this.GraficarEvolucionMin(usuario, fechamin);
        int cont=0;
        
        for(int i=0; i < ListaTotal.size(); i++){
            if((ListaTotal.size()-i)<=ListaMin.size())
            {
                if((ListaTotal.size()-i)==ListaMin.size())
                {
                    Devolucion.add(suma);                    
                }
                Devolucion.add(ListaMin.get(cont));
                Devolucion.add(ListaMin.get(cont+1));
                cont++;
                cont++;
            }
            else
            {                
                suma=suma+Integer.valueOf(String.valueOf(ListaTotal.get(i)));
            }
            i++;
        }
        
        //Funcion
        return Devolucion;
        
         
    }
      
      public Integer BuscarUsuarioId(String nick)
    {
        
        ResultSet res;
         try {
            res = st.executeQuery("select id_user from usuarios where nick='"+nick+"'");
            while(res.next())
            {         
                return Integer.valueOf(String.valueOf(res.getObject(1)));           
            }
            return 0;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return null;
        }
         
    }
       public void registro(String ip, String so, String cliente, String fecha){
         try {
            st.executeUpdate("insert into registro (IP,SO,Cliente,Fecha) values ('"+ip+"','"+so+"','"+cliente+"','"+fecha+"')");
            System.out.println("completado");
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
    }
     
     public boolean registrosi(String fecha,String IP)
    {
        ResultSet res;
         try {
            res = st.executeQuery("select IP,Fecha from registro");
            while(res.next())
            {                 System.out.println(IP);
                              System.out.println(String.valueOf(res.getObject(1)));
                          if(IP.equals(String.valueOf(res.getObject(1))))
                          {
                              System.out.println(fecha);
                              System.out.println(String.valueOf(res.getObject(2)));
                              if(fecha.equals(String.valueOf(res.getObject(2))))
                              {
                                  return false;
                              }
                          }
            }
            return true;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
            return false;
        }
         
    }
}
