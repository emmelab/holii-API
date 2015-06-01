


Mod_FlockCohesion mFlockCohesion = new Mod_FlockCohesion();

class Mod_FlockCohesion extends Modificador {
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
   Atr_Aceleracion[] aceleraciones;

  Mod_FlockCohesion() {
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
      PVector fuerzaC = cohesion(i);
      fuerzaC.mult(1.2);
      aceleraciones[i].a.add(fuerzaC); //-----------------------------------------------------valor de fuerza de cohesion (1.2) podria ser un atributo
    }
  }

  PVector cohesion(int i) {
    PVector suma = new PVector(0, 0, 0);
    int cuenta = 0;

    for (int j = 0 ; j <  sistema.tamano;j++) {  
      if (i != j) {

        float distancia = dist(posiciones[i].p.x, posiciones[i].p.y, posiciones[j].p.x, posiciones[j].p.y );


        if (distancia < 100 && distancia > 0) {//-----------------------------------------------------el espacio de cohesion no es variable por ahora
          suma.add(posiciones[j].p);
          cuenta++;
        }
      }
    }


    if (cuenta > 0) {
      suma.div(cuenta);
      return buscar(suma,i);  // buscar e ir a la ubicacion
    } 
    else {
      return new PVector(0, 0);
    }
  }

  PVector buscar(PVector objetivo, int i) {
    PVector deseo = PVector.sub(objetivo, posiciones[i].p);  // vector desde mi hasta el objetivo
    // escalar el vector a maxima velocidad
    deseo.normalize();
    deseo.mult(2); //----------------------------------------------------------------------------------------- velocidad maxima no varibale por ahora
    // Steering = Desired minus Velocity ---- formula del algun tipo
    PVector conduccion = PVector.sub(deseo, velocidades[i].v);
    conduccion.limit(0.07);  // v-----------------------------------------------------------------------------alor maximo para la conduccion no variable por ahora
    return conduccion;
  }
}





