//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Modo CARTESIANO!
Mod_Gravedad mGravedad = new Mod_Gravedad(HALF_PI, 0.05);

class Mod_Gravedad extends Modificador {
  PVector gravedad;
  Atr_Velocidad[] velocidades;

  Mod_Gravedad(float d, float m) {
    gravedad = PVector.fromAngle(d);
    gravedad.mult(m);
  }

  void atributosObligatorios(Sistema sistema) {
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
  }

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {
      velocidades[i].v.add(gravedad);
    }
  }
}

