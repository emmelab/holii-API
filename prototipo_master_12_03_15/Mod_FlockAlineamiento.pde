

Mod_FlockAlineamiento mFlockAlineamiento = new Mod_FlockAlineamiento();

class Mod_FlockAlineamiento extends Modificador {
  Atr_Posicion[] posiciones;
  Atr_Velocidad[] velocidades;
  Atr_Aceleracion[] aceleraciones;

  Mod_FlockAlineamiento() {
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
       PVector fuerzaA = alinear(i);
       fuerzaA.mult(1.2);//-----------------------------------------------------valor de fuerza de alineamiento (1.2) podria ser un atributo
      aceleraciones[i].a.add(fuerzaA); 
    }
  }

  PVector alinear(int i) {    
    PVector suma = new PVector(0, 0, 0);
    int cuenta = 0;
    for (int j = 0 ; j < sistema.tamano;j++) {     
      if (i != j) {
        float distancia = dist(posiciones[i].p.x, posiciones[i].p.y, posiciones[j].p.x, posiciones[j].p.y );


        if (distancia < 200) {
          suma.add(velocidades[j].v);
          cuenta++;
        }
      }
    }

    if (cuenta > 0) {
      suma.div((float)cuenta);

      // implementar Reynolds: Conducir = deseo - velocidad
      suma.normalize();
      suma.mult(2);
      PVector conduccion = PVector.sub(suma, velocidades[i].v);
      conduccion.limit(0.07);
      return conduccion;
    } 
    else {
      return new PVector(0, 0);
    }
  }
}


