//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> El color inicia Random Hue (tinte), 255 saturacion, 255 brillo
//;;;;;;;;;;;;; -> Cambiado "col" por "c"
class Atr_Color extends Atributo {
  static String key = "Color";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Color();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Color[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  int c;

  //El color inicia Random Hue (tinte), 255 saturacion, 255 brillo
  Atributo[] iniciar(Sistema s, Atributo[] nuevas) {
    s.p5.colorMode(s.p5.HSB);
    for (int i=0; i<nuevas.length; i++) {
      Atr_Color c= (Atr_Color) nuevas[i];
      c.c = s.p5.color(s.p5.random(255), 255, 255); //Si, hacer random en el primer momento de alguna cosa, no queda mal
      //c.c = s.p5.color( (255f*i)/nuevas.length , 255, 255); //Esto reparte los colores equitativamente
    }
    s.p5.colorMode(s.p5.RGB);
    return nuevas;
  }

  //Version anterior
  /*Atributo[] iniciar(Sistema s, Atributo[] nuevas){
   for(int i=0; i<nuevas.length; i++){
   Atr_Color c= (Atr_Color) nuevas[i];
   c.col = s.p5.color(255-(i%2)*255,i%2*255,0); //Los pares son rojos, los impares verdes
   }
   return nuevas;
   }*/
}

