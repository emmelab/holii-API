//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    CAMBIOS 1_11_14
//;;;;;;;;;;;;; -> Modo Cartesiano
//;;;;;;;;;;;;; -> Se detecta colision solo si la particula va "hacia la pared", permitiendo que entren particulas desde fuera :OMG!
//;;;;;;;;;;;;; -> Cambiado "absorcion" por "restitucion" , lo siento, es mas claro 
//;;;;;;;;;;;;; -> Generado un constructor para setear la absorcion
Mod_EspacioCerrado mEspacioCerrado = new Mod_EspacioCerrado(.9);

class Mod_EspacioCerrado extends Modificador {
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
  Atr_Tamano[] tamanios;

  Mod_EspacioCerrado(float restitucion) {
    this.restitucion = restitucion;
  }

  //con esta variable se setea cuanta "energia" NO se pierde, NO se absorbe, con el choque contra la pared
  //es decir si vale 1.0 no se pierde nada de energia, si vale 0.8 se pierde el 20%
  float restitucion;//Voy a aplicar lo que hiciste en "Gravedad" de usar un constructor, aunque aun no estoy seguro

  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
  }

  void atributosOpcionales(Sistema sistema) {
    tamanios = (Atr_Tamano[])sistema.getAtributos(Atr_Tamano.key);
  }


  //Version anterior, genial el coment, pero lo volamos en la proxima
  /*********************** Hay dos opciones a disposicion *********************************
   
   VAMOS CON LA OPCION UNO, ya fue... de todas formas, ahora las velocidades estan en cartesiano
   opcion 1:
   Calcula las componentes X e Y del vector velocidad
   a la componente que choco contra la pared la multiplica por * -absorcionDelRebote
   para invertir la direccion y desacelerar su velocidad
   luego calcula la magnitud de la nueva velocidad usando una raiz cuadrada!!!
   por eso esta opcion consume mas recursos de la PC
   
   opcion 2:
   Calcula las componentes X e Y del vector velocidad
   a la componente que choco contra la pared la multiplica por * -1 para invertir su direccion
   luego multiplica la magnitud de la velocidad por * absorcionDelRebote
   esta opcion desacelera ambas componentes (X e Y) por cada choque
   dando por resultado un efecto menos real, pero sin tanto gasto de los recursos de la PC
   
   NOTA:
   No se si las operaciones coseno y seno consumen muchos recursos calculando las componentes
   pero si se me ocurrio una opcion para evadir eso, sin embargo me parecio que iba a quedar un codigo poco legible
   por lo tanto decidi no hacerlo
   
   **************************************************************************************/

  void ejecutar(Sistema sistema) {
    for (int i=0; i<sistema.tamano; i++) {

      PVector p = posiciones[i].p;
      PVector v = velocidades[i].v;

      float radio = (tamanios != null)? tamanios[i].d/2 : 0 ;

      //De esta forma, la particula rebota solo si va hacia la pared
      if ( p.x < radio && v.x < 0 ) {
        v.x *= -restitucion;
      } else if (p.x > width - radio && v.x > 0) {
        v.x *= -restitucion;
      }
      if ( p.y < radio && v.y < 0 ) {
        v.y *= -restitucion;
      } else if (p.y > height - radio && v.y > 0) {
        v.y *= -restitucion;
      }
    }
  }

  //Version anterior
  /*
  void ejecutar(Sistema sistema){
   for(int i=0;i<sistema.tamano;i++){
   
   Atr_Posicion p = posiciones[i];
   Atr_Velocidad v = velocidades[i];
   
   float tamano = (tamanios != null)? tamanios[i].diametro : 0 ;
   
   if( p.x < tamano/2 || p.x > width - tamano/2 || p.y < tamano/2 || p.y > height -tamano/2){
   
   opcion1( p , v , tamano);
   //opcion2( p , v , tamano);
   
   }
   }
   }
   
   void opcion1( Atr_Posicion p, Atr_Velocidad v, float tamano){
   
   float componenteX = ( v.magnitud * cos(v.direccion) );
   float componenteY = ( v.magnitud * sin(v.direccion) );
   
   //pregunto por que pared choco y le aplico la absorcionDelRebote
   if( p.x < 0 + tamano/2 ){
   p.x= 0 + tamano/2;
   componenteX *= -absorcionDelRebote;
   }else if( p.x > width - tamano/2 ){
   p.x= width - tamano/2;
   componenteX *= -absorcionDelRebote;
   }else if( p.y < 0 + tamano/2 ){
   p.y = 0 + tamano/2;
   componenteY *= -absorcionDelRebote;
   }else if( p.y > height - tamano/2 ){
   p.y = height - tamano/2;
   componenteY *= -absorcionDelRebote;
   }
   
   //calculo la nueva direccion
   v.direccion = atan( componenteY / componenteX );
   if(componenteX < 0) v.direccion += PI;
   
   //calculo la nueva magnitud
   v.magnitud = sqrt( sq(componenteX) + sq(componenteY) );
   
   // funcion de testeo, reinicia la altura cuando la particula se queda en el piso
   if(gravedadAlPiso){
   reiniciar(p,tamano,componenteY);
   }
   
   }
   
   void opcion2( Atr_Posicion p, Atr_Velocidad v, float tamano){
   
   float componenteX = ( v.magnitud * cos(v.direccion) );
   float componenteY = ( v.magnitud * sin(v.direccion) );
   
   //pregunto por que pared choco e invierto su direccion
   if( p.x < 0 + tamano/2 ){
   p.x= 0 + tamano/2;
   componenteX *= -1;
   }else if( p.x > width - tamano/2 ){
   p.x= width - tamano/2;
   componenteX *= -1;
   }else if( p.y < 0 + tamano/2 ){
   p.y = 0 + tamano/2;
   componenteY *= -1;
   }else if( p.y > height - tamano/2 ){
   p.y = height - tamano/2;
   componenteY *= -1;
   }
   
   //calculo la nueva direccion  
   v.direccion = atan( componenteY / componenteX );
   if(componenteX < 0) v.direccion += PI;
   
   //desacelero su magnitud multiplicandola por absorcionDelRebote
   v.magnitud *= absorcionDelRebote;
   
   // funcion de testeo, reinicia la altura cuando la particula se queda en el piso
   if(gravedadAlPiso){
   reiniciar(p,tamano,componenteY);
   }
   }
   
   //esta es una funcion 'demostrativa' solo para que vuelva a empezar el ciclo cuando termina
   void reiniciar(Atr_Posicion p, float tamano, float componenteY) {
   if ( abs(componenteY) <= 0.5 && p.y==height-tamano/2 ) p.y=random(50, 200);
   }*/
}

