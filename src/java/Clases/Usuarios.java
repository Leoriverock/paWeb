
package Clases;

import Clases.ManejadorBD;
import javax.sql.*;
public class Usuarios {
    private String login;
    private String nombre;
    private String Email;
    private String password;
    private String telefono;
    private String direccion;
    private String documento;
    private String sexo;
    private String fecha;

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    private String pais;
   
    
    ManejadorBD mbd = ManejadorBD.getInstancia();

    public String getDireccion() {
        return direccion;
    }
 
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public ManejadorBD getMbd() {
        return mbd;
    }

    public void setMbd(ManejadorBD mbd) {
        this.mbd = mbd;
    }

    
    public Usuarios(){
    super();
    }
    public String getSexo(){
        return sexo;
    }
    public void setSexo(String sexo){
        this.sexo=sexo;
    }
    public String getPais(){
        return pais;
    }
    public void setPais(String Pais){
        this.pais=Pais;
    }
    public String getEmail() {
        return Email;
    }

    public String getNombre() {
        return nombre;  
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }
    public void Registro_Usuario(){
    mbd.registroUsuario(this.getLogin(),this.getNombre(),this.getEmail(),this.getPassword(),this.getTelefono(),this.getDireccion(),this.getDocumento(), this.getSexo(),  this.getPais());
    }
    public void Editar_Registro(){
    mbd.EditarRegistro(this.getDireccion(), this.getPais(), this.getTelefono(), this.getNombre());
    }
    
}
