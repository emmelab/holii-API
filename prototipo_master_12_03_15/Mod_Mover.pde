//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Modo CARTESIANO!
Mod_Mover mMover = new Mod_Mover();

class Mod_Mover extends Modificador {
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
    Atr_Aceleracion[] aceleraciones;

  Mod_Mover() {
  }

  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
  }

  void atributosOpcionales(Sistema sistema) {

    aceleraciones = (Atr_Aceleracion[])sistema.getAtributos(Atr_Aceleracion.key);
  }

  void ejecutar(Sistema sistema) {
    
    for (int i=0; i<sistema.tamano; i++) {
       PVector v = velocidades[i].v; 
     if (aceleraciones != null) {        
        PVector a = aceleraciones[i].a;       
        v.add(a);
      }
      posiciones[i].p.add( v );
      if (aceleraciones != null) {       
        aceleraciones[i].a.mult(0);
      }
    }
  }
}

