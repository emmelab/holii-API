//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    NUEVO 1_11_14
Mod_AtraccionAlCentro mAtraccionAlCentro = new Mod_AtraccionAlCentro(.4*.001);

class Mod_AtraccionAlCentro extends Modificador {
  Atr_Color[] colores;
  Atr_Fuerza[] fuerzas;
  Atr_Posicion[] posiciones;

  float factor;

  Mod_AtraccionAlCentro(float factor) {
    this.factor = factor;
  }

  void atributosObligatorios(Sistema sistema) {
    fuerzas = (Atr_Fuerza[])sistema.getAtributos(Atr_Fuerza.key);
    if (fuerzas == null) fuerzas = (Atr_Fuerza[])sistema.incluir(new Atr_Fuerza());
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
  }

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {
      PVector p=posiciones[i].p;
      PVector f=fuerzas[i].f;
      f.add( PVector.mult(PVector.fromAngle(atan2(height/2-p.y, width/2-p.x)), sistema.tamano*factor) );
    }
  }
}
