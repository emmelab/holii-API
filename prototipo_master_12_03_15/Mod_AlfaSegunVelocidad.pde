Mod_AlfaSegunVelocidad mAlfaSegunVelocidad = new Mod_AlfaSegunVelocidad();

class Mod_AlfaSegunVelocidad extends Modificador{
  Atr_Velocidad[] velocidades;
  Atr_Color[] colores;
  
  void atributosObligatorios(Sistema sistema) {
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
    colores = (Atr_Color[])sistema.getAtributos(Atr_Color.key);
    if (colores == null) colores = (Atr_Color[])sistema.incluir(new Atr_Color());
  }
  
  void ejecutar(Sistema sistema){
    for(int i=0;i<sistema.tamano;i++){
      PVector v = velocidades[i].v;
      int c = colores[i].c;
      
      //calculo alfa segun la velocidad
      float alfa = ( v.magSq() < 20 )? map(v.magSq(),0,20,0,255) : 255 ;
      
      //por algun motivo que desconozco esto no funciona
      //c = color( red(c), green(c) , blue(c) , alfa );
      
      //asi que tuve que hacer asi
      colores[i].c = color( red(c), green(c) , blue(c) , alfa );
      
    }
  }
  
}
