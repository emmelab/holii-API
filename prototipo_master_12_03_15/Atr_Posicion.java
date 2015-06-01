//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Posicion modo PVector
import processing.core.PVector;

class Atr_Posicion extends Atributo {
  static String key = "Posicion";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Posicion();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Posicion[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  PVector p;//Pasado a PVector

  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    int grilla = s.p5.ceil(s.p5.sqrt(nuevas.length));
    int grillaX = grilla;
    int grillaY = grilla;
    for (int i=0; i<nuevas.length; i++) {
      Atr_Posicion p = (Atr_Posicion)nuevas[i];
      p.p = new PVector( (i%grillaX + .5f) * (s.p5.width / grillaX), (i/grillaY + .5f) * (s.p5.height / grillaY) );
     //p.p = new PVector( s.p5.width/2,s.p5.height/2); //desde el centro
    }
    return nuevas;
  }

  //Version anterior
  /*float x,y;
   
   Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
   int grilla = s.p5.ceil(s.p5.sqrt(nuevas.length));
   int grillaX = grilla;
   int grillaY = grilla;
   for (int i=0; i<nuevas.length; i++) {
   Atr_Posicion p = (Atr_Posicion)nuevas[i];
   p.x = (i%grillaX) * (s.p5.width / grillaX);
   p.y = (i/grillaY) * (s.p5.height / grillaY);
   }
   return nuevas;
   }*/
}

