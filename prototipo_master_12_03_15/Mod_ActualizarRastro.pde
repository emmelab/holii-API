//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Cambiado a "ActualizarRastro"
//;;;;;;;;;;;;; -> Modo PVector y vole la necesidad de velocidad
Mod_ActualizarRastro mActualizarRastro = new Mod_ActualizarRastro();

class Mod_ActualizarRastro extends Modificador {
  Atr_Rastro[] rastros;
  Atr_Posicion[] posiciones;

  void atributosObligatorios(Sistema sistema) {
    rastros = (Atr_Rastro[])sistema.getAtributos(Atr_Rastro.key);
    if (rastros == null) rastros = (Atr_Rastro[])sistema.incluir(new Atr_Rastro());
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
  }

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {
      rastros[i].r[0].set( posiciones[i].p );
    }
  }
}

