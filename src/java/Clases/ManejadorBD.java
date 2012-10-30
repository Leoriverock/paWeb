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
}
