//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Fuerza modo PVector
import processing.core.PVector;

class Atr_Fuerza extends Atributo {
  static String key = "Fuerza";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Fuerza();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Fuerza[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  PVector f;//Pasando todo a PVector

  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    for (Atr_Fuerza f : (Atr_Fuerza[])nuevas) {
      f.f = new PVector();
    }
    return nuevas;
  }

  //Version anterior
  //float direccion, magnitud;

  /*Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
   for (Atr_Fuerza f : (Atr_Fuerza[])nuevas) {
   f.direccion = 0;
   f.magnitud = .0f;
   }
   return nuevas;
   }*/
}

