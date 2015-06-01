//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Cambiando todo a una letra... epa! y aca?? (w = ancho, h = alto, d = diametro)
class Atr_Tamano extends Atributo {
  static String key = "Tamano";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Tamano();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Tamano[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  float w, h, d;

  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    for (Atr_Tamano p : (Atr_Tamano[])nuevas) {
      p.w = p.h = p.d = s.p5.random(5, 10)+s.p5.random(5, 10);
    }
    return nuevas;
  }
}

