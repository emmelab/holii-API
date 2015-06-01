//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Cambiado "hijos" por "r", de "rastro", es que, me parece mas claro
//;;;;;;;;;;;;; -> Rastro modo PVector
//;;;;;;;;;;;;; Observaciones: El primer elemento de un rastro seria siempre equivalente a la posicion
import processing.core.PVector;
import processing.core.PApplet;

class Atr_Rastro extends Atributo {
  static String key = "Rastro";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Rastro();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Rastro[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  //Ironicamente, version anterior pero nueva
  PVector[] r = new PVector[10];//Estoy haciendo todos atributos de una letra

  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {     
    Atr_Posicion[] posiciones = (Atr_Posicion[])s.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])s.incluir(new Atr_Posicion());

    for (int i=0; i<nuevas.length; i++) {
      Atr_Rastro r = (Atr_Rastro) nuevas[i];
      for (int j=0; j<r.r.length; j++) {
        r.r[j] = posiciones[i].p.get();// Esto clona una instancia de PVector generando una nueva instancia :D
      }
    }
    return nuevas;
  }

  //Version anterior
  /*float [] hijosx = new float[10];
   float [] hijosy = new float[10];
   
   Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
   Atr_Posicion[] posiciones = (Atr_Posicion[])s.getAtributos(Atr_Posicion.key);
   if (posiciones == null) posiciones = (Atr_Posicion[])s.incluir(new Atr_Posicion());
   
   for (int i=0; i<nuevas.length; i++) {
   Atr_Rastro r = (Atr_Rastro)nuevas[i];
   s.p5.println(posiciones[0].x);
   r.hijosx[0] = posiciones[i].x;
   r.hijosy[0] = posiciones[i].y;
   
   for (int j=1; j<10; j++) {
   r.hijosx[j] = r.hijosx[j-1];
   r.hijosy[j] = r.hijosy[j-1];
   }
   }
   return nuevas;
   }*/
}

