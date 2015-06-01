import processing.core.PApplet;
import java.util.HashMap;
import java.util.ArrayList;

class Sistema {
  boolean debug;
  ArrayList<Modificador> modificadores= new ArrayList<Modificador>();
  ArrayList<Boolean> estadoModificadores  = new ArrayList<Boolean>();

  final PApplet p5;
  int tamano = 100;
  int cantidadModificadores; // agregue esta variable porq no me dejaba utilizar sistema.modificadores.size() para saber la cantidad de modificadores asi que uso sistema.cantidadModificadores
  HashMap<String, Atributo[]> atributos;

  Sistema(PApplet p5, int cantidad) {
    this.p5 = p5;
    tamano = cantidad;
    atributos = new HashMap();
  }

  void actualizar() {

    for (int i = 0; i<modificadores.size (); i++) {
      if (getEstadoModificador(i)) {
        getModificador(i).modificar(this);
      }
    }
  }

  Atributo[] incluir(Atributo semilla) {
    if (atributos.containsKey( semilla.getKey() )) {
      System.out.println("Esta llave ya está en uso"+semilla.getKey());
      p5.exit();
      return null;
    } 
    else {
      Atributo[] nuevas = semilla.generarGrupo(this);
      atributos.put(semilla.getKey(), nuevas);
      return nuevas;
    }
  }

  Atributo[] getAtributos(String llave) {
    return atributos.get(llave);
  }

  Modificador getModificador(int posicion) {
    return modificadores.get(posicion);
  }
  
  int getCantidadModificadores() {
    return modificadores.size();
  }
  void setEstadoModificador(int posicion, boolean estado) {
    estadoModificadores.set(posicion, estado);
  }

  void prenderModificador(int posicion) {
    estadoModificadores.set(posicion, true);
  }

  void apagarModificador(int posicion) {
    estadoModificadores.set(posicion, false);
  }

  boolean getEstadoModificador(int posicion) {
    return estadoModificadores.get(posicion);
  }

  void agregarModificador(Modificador modificador) {
    modificadores.add(modificador);
    estadoModificadores.add(true);
  }

  void agregarModificador(Modificador modificador, boolean estado) {
    modificadores.add(modificador);
    estadoModificadores.add(estado);
  }

  void agregarModificador(Modificador modificador, int posicion) {
    modificadores.add(posicion, modificador);
    estadoModificadores.add(posicion, true);
  }

  void agregarModificador(Modificador modificador, int posicion, boolean estado) {
    modificadores.add(posicion, modificador);
    estadoModificadores.add(posicion, estado);
  }

  void eliminarModificador(int posicion) {
    modificadores.remove(posicion);
    estadoModificadores.remove(posicion);
  }
}

