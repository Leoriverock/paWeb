package Clases;
public class Equipos {
   String id;
   String nombre;
   
   public void setId(String id){
    this.id = id;
   }
   
   public String getID(){
       return this.id;
   }
   
   public void setNombre(String nombre){
    this.nombre = nombre;
   }
   
   public String getNombre(){
       return this.nombre;
   }
}
/*La clase Equipos se utiliza para mejorar la gestion de los datos, al realizar las consultas se iran correspondiendo
 * con una instancia de la clase. Se utiliza tambien al momento de crear la tabla dinamica en el formulario jsp
 */