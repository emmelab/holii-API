//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Agragado factor multiplicador de la fuerza final
//;;;;;;;;;;;;; -> Cambiado array de fuerzas en juego, por una fuerza que va sumando
//;;;;;;;;;;;;; -> Ahora la semejanza es por tinte, y no necesitan ser exactamente iguales, solo parecido
//;;;;;;;;;;;;; -> Cambio nombre por "FuerzasPorSemejanza"
//;;;;;;;;;;;;; -> Modo CARTESIANO!
Mod_FuerzasPorSemejanza mFuerzasPorSemejanza = new Mod_FuerzasPorSemejanza(.001);

class Mod_FuerzasPorSemejanza extends Modificador {
  Atr_Color[] colores;
  Atr_Fuerza[] fuerzas;
  Atr_Posicion[] posiciones;

  float factor;

  Mod_FuerzasPorSemejanza(float factor) {
    this.factor = factor;
  }

  void atributosObligatorios(Sistema sistema) {
    colores = (Atr_Color[])sistema.getAtributos(Atr_Color.key);
    if (colores == null) colores = (Atr_Color[])sistema.incluir(new Atr_Color());
    fuerzas = (Atr_Fuerza[])sistema.getAtributos(Atr_Fuerza.key);
    if (fuerzas == null) fuerzas = (Atr_Fuerza[])sistema.incluir(new Atr_Fuerza());
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
  }

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {
      PVector p=posiciones[i].p;
      color c=colores[i].c;
      float tinte = hue(c);
      PVector f=fuerzas[i].f;
      PVector atraccionFinal = new PVector();
      //PVector[] vector=new PVector[sistema.tamano]; //Cambiado a una fuerza que suma todo
      //vector[i]=new PVector(0,0);//Eesto es raro?

      for (int j=0; j<sistema.tamano; j++) {
        if (i!=j) {

          PVector pj = posiciones[j].p;
          color cj = colores[j].c;
          float diferenciaTinte = abs( hue(cj)-tinte );

          //calculo la direccion entre la particula y la otra
          float angulo = atan2( p.y-pj.y, p.x-pj.x );

          if ( diferenciaTinte <= 63 || diferenciaTinte > 191 ) {
            atraccionFinal.add ( PVector.fromAngle(angulo + PI) );
          } else {
            atraccionFinal.add ( PVector.fromAngle(angulo) );
          }

          if (sistema.debug) {
            if (dist(mouseX, mouseY, p.x, p.y) < 15) dibujarDebug(p, pj, diferenciaTinte <= 63 || diferenciaTinte > 191);
          }
        }
      }

      f.add(atraccionFinal);
      f.mult( factor );
      //f.add( PVector.mult(PVector.fromAngle(atan2(height/2-p.y,width/2-p.x)),factor*sistema.tamano*.4) );
    }
  }

  void dibujarDebug(PVector desde, PVector hasta, boolean atrae) {
    pushStyle();
    stroke( atrae?0:255, atrae?255:0, 0); 
    line( desde.x, desde.y, hasta.x, hasta.y);
    popStyle();
  }
  //Version anterior
  /*
  void ejecutar(Sistema sistema){
   
   //la version 1 era mas optima... pero..... no andaba visualmente como esperaba... por lo que creo que me estaba/estoy confundiendo
   //version1(sistema);
   
   //la version 2... es lo mismo pero no tan optimo, igual .......
   version2(sistema);
   
   }
   
   void version2(Sistema sistema){
   for(int i=0;i<sistema.tamano;i++){
   Atr_Posicion p=posiciones[i];
   Atr_Color c=colores[i];
   Atr_Fuerza f=fuerzas[i];
   PVector[] vector=new PVector[sistema.tamano];
   vector[i]=new PVector(0,0);
   
   for(int j=0;j<sistema.tamano;j++){
   if(i!=j){
   
   Atr_Posicion pj = posiciones[j];
   Atr_Color cj = colores[j];
   
   //calculo la direccion entre la particula y la otra
   float angulo = atan( pj.y - p.y / pj.x - p.x );
   if(pj.x - p.x < 0) angulo += PI;
   
   if( c.col == cj.col){
   vector[j] = PVector.fromAngle(angulo);
   }else{
   vector[j] = PVector.fromAngle(angulo+PI);
   }
   
   }
   }
   
   PVector vectorSuma=new PVector();
   for(int j=0;j<sistema.tamano;j++){
   vectorSuma.add(vector[j]);
   }
   //vectorSuma.normalize();
   
   float direccionVectorSuma = atan( vectorSuma.y / vectorSuma.x );
   if( vectorSuma.x < 0 ) direccionVectorSuma += PI;
   
   f.direccion = ( Float.isNaN(direccionVectorSuma) ) ? 0 : direccionVectorSuma;
   f.magnitud=0.01;
   
   // aca esta lo de la velocidad xD
   //Atr_Velocidad v = velocidades[i];
   //v.direccion = ( Float.isNaN(direccionVectorSuma) ) ? 0 : direccionVectorSuma;
   //
   
   }
   }
   
   
   void version1(Sistema sistema){
   //hago un vector de 2 dimensiones (matriz) donde voy a guardar vectores unitarios,
   //por cada particula del sistema guardo vectores apuntando a las otras particulas
   PVector[][] fvectores = new PVector[sistema.tamano][sistema.tamano];
   
   //recorro el sistema
   for(int i=0; i < sistema.tamano; i++){
   
   // me posiciono en una de las particulas
   Atr_Posicion p_i = posiciones[i];
   Atr_Color c_i = colores[i];
   Atr_Fuerza f = fuerzas[i];
   
   //recorro el resto de las particulas
   for(int j=i+1;j<sistema.tamano; j++){
   Atr_Posicion p_j = posiciones[j];
   Atr_Color c_j = colores[j];
   
   //calculo la direccion entre la particula y la otra
   float angulo = atan( p_j.y - p_i.y / p_j.x - p_i.x );
   if(p_j.x - p_i.x < 0) angulo += PI;
   
   //guardo dicha direccion para la particula y para la otra
   //debo saber si se atraen o si se rechazan
   if( c_i.col == c_j.col){
   fvectores[i][j] = PVector.fromAngle(angulo);
   fvectores[j][i] = PVector.fromAngle(angulo-PI);
   }else{
   fvectores[i][j] = PVector.fromAngle(angulo-PI);
   fvectores[j][i] = PVector.fromAngle(angulo);
   }
   
   }
   
   //calculo el vector resultante 
   PVector vectorResultado=new PVector();
   for(int j=0;j<sistema.tamano;j++){
   if(i!=j)vectorResultado.add(fvectores[i][j]);
   }
   
   //calculo el angulo resultante del vectorResultado
   float direccionFinal = atan( vectorResultado.y / vectorResultado.x );
   if(vectorResultado.x < 0) direccionFinal += PI;
   
   //aplico la direccion a mi particula
   f.direccion=( Float.isNaN(direccionFinal) )? 0 : direccionFinal;
   println(f.direccion);
   f.magnitud=0.01;
   
   
   }
   }
   */
}

