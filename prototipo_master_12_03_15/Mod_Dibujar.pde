//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
Mod_Dibujar mDibujar=new Mod_Dibujar();

class Mod_Dibujar extends Modificador { 
  Atr_Posicion[] posiciones;
  Atr_Tamano[] tamanios;
  Atr_Color[] colores;

  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion()); 
    tamanios = (Atr_Tamano[])sistema.getAtributos(Atr_Tamano.key);
    if (tamanios == null) tamanios = (Atr_Tamano[])sistema.incluir(new Atr_Tamano());
  }

  void atributosOpcionales(Sistema sistema) {
    colores = (Atr_Color[])sistema.getAtributos(Atr_Color.key);
  }

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {
      PVector p = posiciones[i].p;
      Atr_Tamano t = tamanios[i];

      if (colores != null) {
        pushStyle();
        fill(colores[i].c);
      }
      ellipse(p.x, p.y, t.d, t.d);
      if (colores != null) {
        popStyle();
      }
    }
  }
}

