
package itv2;

/**
 * @author Acer
 */
import java.util.Scanner;
public class Menu {
    private String Titols[]={   "1. Alta i recepció de vehicles\n", 
                                "2. Reclamar vehicle per a entrar al box\n",     
                                "3. Moure tots els vehicles de fase dins d’un box\n",
                                "4. Informació de l'estat d'un box concret\n",
                                "5. Informació general de tots els boxes\n",
                                "6. Eixir del programa\n"};
    
    public void mostrar(){
        System.out.println("Menu d'opcions: ");
        for(int i = 0; i<Titols.length; i++ ){
            System.out.print(Titols[i]);
        }
    }
    public int llegirOpcio(){
        Scanner input = new Scanner(System.in); 
        int opcio=0;
        boolean salir=false;
        
           while(!salir){
               System.out.print("Seleccione una opcio ente 1 i 6: ");

               if(input.hasNextInt()){
                    opcio=input.nextInt();
               }
                    if(opcio>=1&&opcio<=6){
                        salir=true;
                    }
                    else{
                         System.out.println("La opcio ha de ser un nombre entre 1 i 6");
                    }   
               
               input.nextLine();
           }
           return opcio;
    }
    
}
    
  
