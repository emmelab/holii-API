
Mod_FlockSeparacion mFlockSeparacion = new Mod_FlockSeparacion();

class Mod_FlockSeparacion extends Modificador {
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
  Atr_Aceleracion[] aceleraciones;

  Mod_FlockSeparacion() {
  }

  void atributosObligatorios(Sistema sistema) {
    posiciones = (Atr_Posicion[])sistema.getAtributos(Atr_Posicion.key);
    if (posiciones == null) posiciones = (Atr_Posicion[])sistema.incluir(new Atr_Posicion());
    velocidades = (Atr_Velocidad[])sistema.getAtributos(Atr_Velocidad.key);
    if (velocidades == null) velocidades = (Atr_Velocidad[])sistema.incluir(new Atr_Velocidad());
    aceleraciones = (Atr_Aceleracion[])sistema.getAtributos(Atr_Aceleracion.key);
    if (aceleraciones == null) aceleraciones = (Atr_Aceleracion[])sistema.incluir(new Atr_Aceleracion());
  }



  void ejecutar(Sistema sistema) {
    for (int i = 0 ; i <  sistema.tamano;i++) {  
      PVector fuerzaS = separacion(i);
      fuerzaS.mult(1.7);
      aceleraciones[i].a.add(fuerzaS); //-----------------------------------------------------valor de fuerza de cohesion (1.2) podria ser un atributo
    }
  }

  PVector separacion(int i) {
    //separacion
    PVector conduccion = new PVector(0, 0, 0);
    int cuenta = 0;
    for (int j = 0 ; j <  sistema.tamano;j++) {     
      if (i != j) {

        float distancia = dist(posiciones[i].p.x, posiciones[i].p.y, posiciones[j].p.x, posiciones[j].p.y );

        if (distancia < 100 && distancia > 0) {//-----------------------------------------------------el espacio de cohesion no es variable por ahora

          PVector diferencia = PVector.sub(posiciones[i].p, posiciones[j].p);
          diferencia.normalize();
          diferencia.div(distancia);        //dar una fuerza segun al distancia
          conduccion.add(diferencia);
          cuenta++;   //saber cuantas relaciones
        }
      }
    }

    if (cuenta > 0) {
      conduccion.div((float)cuenta);//promedio de la conduccion
    }

    if (conduccion.mag() > 0) {

      // implementar Reynolds: Conducir = deseo - velocidad
      conduccion.normalize();
      conduccion.mult(2);//----------------------------------------------------------------------------------------- velocidad maxima no varibale por ahora
      conduccion.sub(velocidades[i].v);
      conduccion.limit(0.07);// v-----------------------------------------------------------------------------alor maximo para la conduccion no variable por ahora
    }
    return conduccion;
  }
}





