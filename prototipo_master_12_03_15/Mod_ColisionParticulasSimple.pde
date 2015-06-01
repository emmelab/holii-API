//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    NUEVO 1_11_14
Mod_ColisionParticulasSimple mColisionParticulasSimple = new Mod_ColisionParticulasSimple(.7);

class Mod_ColisionParticulasSimple extends Modificador {
  Atr_Velocidad[] velocidades;
  Atr_Posicion[] posiciones;
  Atr_Tamano[] tamanos;

  float elasticidad;

  Mod_ColisionParticulasSimple(float elasticidad) {
    this.elasticidad = elasticidad;
  }

  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
    tamanos = (Atr_Tamano[])sistema.getAtributos(Atr_Tamano.key);
    if (tamanos == null) tamanos = (Atr_Tamano[])sistema.incluir(new Atr_Tamano());
  }

  void atributosOpcionales(Sistema sistema) {
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
  }

  void ejecutar(Sistema sistema) { 
    for (int i=0; i<sistema.tamano; i++) {

      PVector vel = null;
      if (velocidades != null) vel = velocidades[i].v;
      PVector pos = posiciones[i].p;
      float radio = tamanos[i].d/2;
      ArrayList<PVector> expulsion = new ArrayList();
      ArrayList<Float> importancia = new ArrayList();
      float importanciaTotal = 0;
      for (int j=0; j<sistema.tamano; j++) {
        if (i!=j) {

          PVector posj = posiciones[j].p;
          float radioj = tamanos[j].d/2;
          float distChoque2 = (radio+radioj)*(radio+radioj);
          float dist2 = (pos.x-posj.x)*(pos.x-posj.x)+(pos.y-posj.y)*(pos.y-posj.y);
          if (dist2 < distChoque2) {
            float magnitud = (radio+radioj)-sqrt(dist2);
            if (magnitud == 0) continue;
            PVector direccion = PVector.fromAngle( atan2( pos.y-posj.y, pos.x-posj.x ) );
            direccion.mult(magnitud);
            expulsion.add(direccion);
            importancia.add(magnitud);
            importanciaTotal += magnitud;

            if (sistema.debug) {
              dibujarDebug(pos, radio);
            }
          }
        }
      }

      if (importanciaTotal > 0) {
        PVector expulsionFinal = new PVector();
        for (int e=0; e<expulsion.size (); e++) {
          PVector expulsionLocal = expulsion.get(e);
          expulsionLocal.mult( importancia.get(e) / importanciaTotal );
          expulsionFinal.add(expulsionLocal);
        }
        if (vel == null)
          pos.add(expulsionFinal);
        else {
          PVector fuerza = expulsionFinal.get();
          fuerza.mult(elasticidad);
          expulsionFinal.mult(1-elasticidad);
          pos.add(expulsionFinal);
          vel.add(fuerza);
        }
      }
    }
  }

  void dibujarDebug(PVector pos, float radio) {
    pushStyle();
    noFill();
    stroke(0, 255, 0);
    ellipse(pos.x, pos.y, radio*2.3, radio*2.3);
    popStyle();
  }
}

