
package Clases;

public class Date {
    private int dia, mes, anio;
    
    public Date(int dd, int mm, int aa){
        dia = dd;
        mes = mm;
        anio = aa;
    }
    
    public int getDia() {
        return dia;
    }
    
    public void setDia(int dia) {
        this.dia = dia;
    }
    
    public int getMes() {
        return mes;
    }
    
    public void setMes(int mes) {
        this.mes = mes;
    }
    
    public int getAnio() {
        return anio;
    }
    public void setAnio(int anio) {
        this.anio = anio;
    }
    
    public static boolean esCorrecta(int d, int m, int a){
        int diasDelMes[]={31,29,31,30,31,30,31,31,30,31,30,31};
        
        if(a<=0) {
            return false;
        }
        if(d<=0 || d>31) {
            return false;
        }
        if(m<=0 || m>12) {
            return false;
        }
        if(d>diasDelMes[m-1]) {
            return false;
        }
        if(m==2 && d==29 && !esBisiesto(a)) {
            return false;
        }
        return true;
    }
    
    static boolean esBisiesto(int a){
        if ((a%4==0) || (a%400==0) && (a%100!=0)) {
            return true;
        }
        else {
            return false;
        }
    }
    
    public String DateToString(){
        String dia_string = Integer.toString(this.dia);
        String mes_string = Integer.toString(this.mes);
        String anio_string = Integer.toString(this.anio);
        
        if(this.dia<10) {
            dia_string = "0"+dia_string;
        }
        if(this.mes<10) {
            mes_string = "0"+mes_string;
        }
        
        String res = anio_string+"-"+mes_string+"-"+dia;
        return res;
    }
}


