//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Pasado el dibujo a una funcion aparte "DibujoDebug"
//;;;;;;;;;;;;; -> Uso de la velocidad E L I M I N A D O, jojojojo! soy malo!
//;;;;;;;;;;;;; -> Usando tecnica de "gravedad", se setea el factor en el constructor
//;;;;;;;;;;;;; -> Pasado a PVEctor
Mod_RastroElastico mRastroElastico = new Mod_RastroElastico(.08);

class Mod_RastroElastico extends Modificador {
  Atr_Rastro[] rastro;
  //Atr_Velocidad[] velocidades;

  float factor;

  Mod_RastroElastico(float factor) {
    this.factor = factor;
  }

  void atributosObligatorios(Sistema sistema) {
    rastro = (Atr_Rastro[])sistema.getAtributos(Atr_Rastro.key);
    if (rastro == null) rastro = (Atr_Rastro[])sistema.incluir(new Atr_Rastro());
  }
  /*
  void atributosOpcionales(Sistema sistema) {
   velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
   }
   */

  void ejecutar(Sistema sistema) {
    for (int i = 0; i < sistema.tamano; i++) {
      for (int j = 1; j < rastro[i].r.length; j++) {
        rastro[i].r[j].lerp( rastro[i].r[j-1], factor );
      }
    }
    dibujoDebug();
  }

  void dibujoDebug() {
    Atr_Color[] c = (Atr_Color[])sistema.getAtributos(Atr_Color.key);
    pushStyle();
        noFill();
    if (c == null)
      stroke(127);
    for (int i = 0; i < sistema.tamano; i++) {
      if (c != null) {
        color col = c[i].c;
        col = color( red(col)/2 , green(col)/2 , blue(col)/2 );
        stroke(col);
      }
      for (int j = 0; j < rastro[i].r.length; j++) {
        PVector pos = rastro[i].r[j];
        triangle(pos.x, pos.y-5, pos.x+5, pos.y+5, pos.x-5, pos.y+5);
      }
    }
    popStyle();
  }
  
  //Version anterior
  /*
  void ejecutar(Sistema sistema) {
   if (velocidades != null) {
   for (int i=0; i<sistema.tamano; i++) {
   factor[i] = velocidades[i].magnitud*0.1;
   }
   }
   
   for (int i = 0; i < sistema.tamano; i++) {
   for (int j = 1; j < 10; j++) {
   //rastro[i].hijos[j].set(lerp(rastro[i].hijos[j].x, rastro[i].hijos[j-1].x, factor[i]), lerp(rastro[i].hijos[j].y, rastro[i].hijos[j-1].y, factor[i]), 0);
   rastro[i].hijosx[j] = lerp(rastro[i].hijosx[j], rastro[i].hijosx[j-1], factor[i]);
   rastro[i].hijosy[j] = lerp(rastro[i].hijosy[j], rastro[i].hijosy[j-1], factor[i]);
   }
   }
   
   }*/
}

