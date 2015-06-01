//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Velocidad modo PVector
//;;;;;;;;;;;;; -> Modo CARTESIANO!
import processing.core.PVector;

class Atr_Velocidad extends Atributo {
  static String key = "Velocidad";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Velocidad();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Velocidad[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  PVector v;
  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    for (Atr_Velocidad v : (Atr_Velocidad[])nuevas) {
      v.v = PVector.fromAngle( s.p5.random(s.p5.TWO_PI) );
      v.v.mult( s.p5.random(.05f, 2) );
    }
    return nuevas;
  }

  //Version anterior
  /*
  float direccion,magnitud;
   
   Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
   for (Atr_Velocidad p : (Atr_Velocidad[])nuevas) {
   p.direccion = s.p5.random(s.p5.PI,s.p5.TWO_PI);
   p.magnitud = s.p5.random(.05f,2);
   }
   return nuevas;
   }*/
}

