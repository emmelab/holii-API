
class Consola {

  float borde;
  float espaciado;
  float alto;
  float ancho;

  PVector[] pos; 

  int c;

  ArrayList<Boolean> datos;
  ArrayList<String> nombres;
  boolean[] estado;
  boolean[] sensible;

  int botonesPorDefecto;
  String[] nombresPorDefecto;

  boolean nivelAgregar = false;
  boolean nivelQuitar = false;
  boolean nivelOpciones = false;

  ArrayList<String> nombresBDD;

  Consola() { //c = cantidad de modificadores

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    strokeWeight(0.5);


    borde = width/8;
    espaciado = (height-height/10)/17;
    alto = espaciado/1.2;   
    ancho = width/3+20;    

    c = 0;
    nombres = new ArrayList<String>();
    datos = new ArrayList<Boolean>();
    nombresBDD = new ArrayList<String>();

    botonesPorDefecto = 3;

    pos = new PVector[c+botonesPorDefecto];    
    estado = new boolean[c+botonesPorDefecto];
    sensible = new boolean[c+botonesPorDefecto];

    nombresPorDefecto = new String[botonesPorDefecto];

    nombresPorDefecto[0] = " AgReGaR MoDiFiCaDoR";
    nombresPorDefecto[1] = " qUiTaR mOdIfIcAdOr";
    nombresPorDefecto[2] = " OPCIONES";


    for (int i=0 ;i<botonesPorDefecto;i++) {
      pos[i] = new PVector(borde+borde, borde+espaciado*i);
    }
    for (int i= botonesPorDefecto;i<c+botonesPorDefecto;i++) {
      pos[i] = new PVector(borde/1.5+borde*2+ancho, borde+espaciado*(i-botonesPorDefecto));
    }
  }


  void ejecutar() {
    revisarSensible();
    nivel1();

    if (nivelAgregar || nivelQuitar || nivelOpciones) {
      nivel2();
    }
  }

  void nivel1() {

    fill( colorBoton);
    stroke( lineaBoton);
    for (int i=0;i<botonesPorDefecto;i++) {
      rect(pos[i].x, pos[i].y, ancho, alto);
    }



    for (int i=0;i<botonesPorDefecto;i++) {
     if (sensible[i]) {
        fill( letrasActivas);
        textSize(17);
      }
      else {
        fill( letras);
        textSize(12);
      }
      text(nombresPorDefecto[i], pos[i].x, pos[i].y);
    }
  }

  void nivel2() {
    botones();
    botonesNombres();
  }



  void botones() {
    fill( colorBoton);
    stroke( lineaBoton);
    for (int i=botonesPorDefecto;i<c+botonesPorDefecto;i++) {
      rect(pos[i].x, pos[i].y, ancho, alto);
    }
  }

  void botonesNombres() {

    for (int i=botonesPorDefecto;i<c+botonesPorDefecto;i++) {
      if (sensible[i]) {
        fill( letrasActivas);
        textSize(17);
      }
      else {
        fill( letras);
        textSize(12);
      }
      if (nivelAgregar || nombresBDD.size() != nombres.size() )  text(nombres.get(i-botonesPorDefecto), pos[i].x, pos[i].y);
      if (nivelQuitar && nombresBDD.size() == nombres.size())  text(nombres.get(i-botonesPorDefecto) + nombresBDD.get(i-botonesPorDefecto), pos[i].x, pos[i].y);
      if (nivelOpciones)  text(nombres.get(i-botonesPorDefecto), pos[i].x, pos[i].y);
    }
  }


  void activar() {

    for (int i=0;i<c+botonesPorDefecto;i++) {
      if (mouseX>pos[i].x-ancho/2 && mouseX<pos[i].x+ancho/2 && mouseY>pos[i].y-alto/2 && mouseY<pos[i].y+alto/2) {
        estado[i] = true;
      }
    }
  }

  void revisarSensible() {
    for (int i=0;i<c+botonesPorDefecto;i++) {
      if (mouseX>pos[i].x-ancho/2 && mouseX<pos[i].x+ancho/2 && mouseY>pos[i].y-alto/2 && mouseY<pos[i].y+alto/2) {
        sensible[i] = true;
      } 
      else {
        sensible[i] = false;
      }
    }
  }

  void botonesDesactivar() {
    for (int i=0;i<c+botonesPorDefecto;i++) {
      estado[i] = false;
    }
  }

  void botonesAcciones() {
    if (estado[0] == true) {   
      mandarMensaje("/pedir/modificadores/total"); 

      nivelAgregar = true;
      nivelQuitar=false;
      nivelOpciones = false;
    } 

    if (estado[1] == true) {    
      mandarMensaje("/pedir/modificadores/existentes");

      nivelQuitar=true;
      nivelAgregar = false;
      nivelOpciones = false;
    }

    if (estado[2] == true) {   
      mandarMensaje("/pedir/opciones");

      nivelOpciones = true;
      nivelQuitar=false;
      nivelAgregar = false;
    }


    for (int i= c+botonesPorDefecto-1;i>=botonesPorDefecto;i--) {
      if (estado[i] && nivelAgregar) {
        OscMessage mensajeModificadores;
        mensajeModificadores = new OscMessage("/agregar/modificadores");
        mensajeModificadores.add(nombres.get(i-botonesPorDefecto)); 

        nombresBDD.add(nombres.get(i-botonesPorDefecto));


        oscP5.send(mensajeModificadores, sistema);
      }
      else if (estado[i] && nivelQuitar) {
        removerOreajustarBaseDeDatos(i);
        OscMessage mensajeModificadores;
        mensajeModificadores = new OscMessage("/quitar/modificadores");
        mensajeModificadores.add(i-botonesPorDefecto);           
        oscP5.send(mensajeModificadores, sistema);
      } 
      else if (estado[i] && nivelOpciones) {
        OscMessage mensajeModificadores;
        mensajeModificadores = new OscMessage("/accion/opciones");
        mensajeModificadores.add(nombres.get(i-botonesPorDefecto));
        if (nombres.get(i-botonesPorDefecto).equals("reset"))resetar(); 
        oscP5.send(mensajeModificadores, sistema);
      }
    }


    botonesDesactivar();
  }

  void renovarDatos( int c_, ArrayList<Boolean>datos_, ArrayList<String>nombres_) {
    c = c_;
    nombres = nombres_;
    datos = datos_;



    pos = new PVector[c+botonesPorDefecto];    
    estado = new boolean[c+botonesPorDefecto];
    sensible = new boolean[c+botonesPorDefecto];

    for (int i=0 ;i<botonesPorDefecto;i++) {
      pos[i] = new PVector(borde+borde, borde+espaciado*i);
    }
    for (int i= botonesPorDefecto;i<c+botonesPorDefecto;i++) {
      pos[i] = new PVector(borde/1.5+borde*2+ancho, borde+espaciado*(i-botonesPorDefecto));
    }
  }

  void mandarMensaje(String mensaje) {
    OscMessage mensajeModificadores;
    mensajeModificadores = new OscMessage(mensaje);
    oscP5.send(mensajeModificadores, sistema);
  }

  void removerOreajustarBaseDeDatos(int indice) {
    if (nombresBDD.size() == nombres.size()) {
      nombresBDD.remove(indice-botonesPorDefecto);
    } 
    else {
      for (int j= 0;j<nombresBDD.size();j++) {
        nombresBDD.remove(j);
      }
      for (int j= 0;j<nombres.size()-1;j++) {
        nombresBDD.add("indefinido");
      }
    }
  }

  void resetar() {
    nombresBDD = new ArrayList<String>();
    boolean nivelAgregar = false;
    boolean nivelQuitar = false;
    boolean nivelOpciones = false;
    c = 0;
    nombres = new ArrayList<String>();
    datos = new ArrayList<Boolean>();
    nombresBDD = new ArrayList<String>();
  }
}

