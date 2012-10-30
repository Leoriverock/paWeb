/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function votar() { 
                    monto=oForm["monto"].value;
                    div=document.getElementById("divs").value;
                    newstr="".concat("Apuesta = ", monto, ". En caso de ganar ganaria: ", monto*divs, "Desea realizar la apuesta?");
                pregunta = confirm(newstr) ; 
                if(pregunta) { 
                open('url','top=100,left=100,width=250,height=250') ;
                } 
                } 
                
                function algo(){
                    alert("hola");
                }

