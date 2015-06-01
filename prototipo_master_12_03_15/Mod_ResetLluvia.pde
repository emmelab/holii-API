Mod_ResetLluvia mResetLluvia = new Mod_ResetLluvia();

class Mod_ResetLluvia extends Modificador{
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
  
  //valor interesante con el cual jugar
  //es la magnitud al cuadrado minima de la velocidad que puede tener una particula para no resetearse
  float umbralVelocidadMinima = 0.05;
  
  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
  }
  
  void ejecutar(Sistema sistema){
    for(int i=0;i<sistema.tamano;i++){
      PVector v = velocidades[i].v;
      PVector p = posiciones[i].p;
      
      //pregunto por si la particula esta cerca del piso
      //y por si la magnitud cuadrada de la velocidad es muy baja ( no hace falta sacar la raiz cuadrada o usar mag() )
      if( p.y > 7*height/8 && v.magSq() < umbralVelocidadMinima){
        
        //en caso de ser cierto solo reseteo la posicion en el eje Y
        p.y = random(200);
        
        // mmmmm opcional para mas caos
        //p.x= random(width);
        
      }
      
    }
  }
  
}
