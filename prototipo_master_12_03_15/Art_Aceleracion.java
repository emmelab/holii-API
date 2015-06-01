import processing.core.PVector;

class Atr_Aceleracion extends Atributo {
  static String key = "Aceleracion";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Aceleracion();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Aceleracion[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  PVector a;
  
  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    for (Atr_Aceleracion p : (Atr_Aceleracion[])nuevas) {
      p.a = new PVector(0,0);
    }
    return nuevas;
  }
  
}
