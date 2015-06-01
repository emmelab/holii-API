Mod_EspacioToroidal mEspacioToroidal = new Mod_EspacioToroidal();

class Mod_EspacioToroidal extends Modificador{
  Atr_Posicion[] posiciones;
  Atr_Tamano[] tamanios;
  
  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
  }

  void atributosOpcionales(Sistema sistema) {
    tamanios = (Atr_Tamano[])sistema.getAtributos(Atr_Tamano.key);
  }
  
  void ejecutar(Sistema sistema){
    for(int i=0;i<sistema.tamano;i++){
      PVector p = posiciones[i].p;
      float radio = (tamanios != null)? tamanios[i].d/2 : 0 ;
      
      p.x = ( p.x < 0-radio )? width+radio : ( p.x > width+radio )? 0-radio : p.x;
      p.y = ( p.y < 0-radio )? height+radio : ( p.y > height+radio )? 0-radio : p.y;
    }
  }
  
}
