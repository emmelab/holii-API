//-------------------------------------
//resolver un ropblema con el flock y quiza con otro modificadores
//cuando algun modificador no esta funcional puede que algunos aributos se modifiquen constantemente y cuadno se activa el modificador pasan cosas malas....
//ejemplo cuando mover se desactiva el flock sigue aumentando la aceleracion que no se resetea como deberia....
//opciones ubicar el reseteo de la aceleracion como parte constante de la existencia del mismo... o algo parecido....
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress consola;


Sistema sistema;

boolean pausa; 
boolean fondoAlfa;

int posModificadorMover;
int raizDeCantidad = 12;

int cantidadModificadores = 16;
int cantidadOpciones = 5;

String[] nombres = new String[cantidadModificadores];
Modificador[] TodosLosModificadores = new Modificador[cantidadModificadores];
String[] opciones = new String[cantidadOpciones];



void setup() {
  size(800, 600);
  sistema = new Sistema(this, raizDeCantidad*raizDeCantidad);


  //---------------------------------------------------------------------------MODIFICADORES TOTAL----------------------------------------------------------------------------

  cargarNombresDeTodosLosModificadores();
  cargarTodosLosModificadores();
  cargarOpciones();

  noSmooth();
  noStroke();

  oscP5 = new OscP5(this, 12050);
  consola = new NetAddress("127.0.0.1", 12000);

  oscP5.plug(this, "opciones", "/pedir/opciones");
  oscP5.plug(this, "modificadoresTotal", "/pedir/modificadores/total");
  oscP5.plug(this, "modificadoresExistentes", "/pedir/modificadores/existentes");
  oscP5.plug(this, "modificadoresAgregar", "/agregar/modificadores");
  oscP5.plug(this, "modificadoresQuitar", "/quitar/modificadores");
  oscP5.plug(this, "accionOpciones", "/accion/opciones");
}



void draw() {
  if (!pausa) {
    ciclo();
  }
}

void ciclo() { 
  if (fondoAlfa) {
    pushStyle();
    fill(0, 20);
    rect(0, 0, width, height);
    popStyle();
  } 
  else {
    background(0);
  }

  sistema.actualizar();

  fill(255);
  text(frameRate, 5, 10);
}


//rest, pause, cambio de alfa del fondo y sistema.debug... 
//se puede agregar como botones default si son necesarios...... 

void reset() {
  background(0);
  sistema = new Sistema(this, raizDeCantidad*raizDeCantidad);
  String[] nombres = new String[cantidadModificadores];
  Modificador[] TodosLosModificadores = new Modificador[cantidadModificadores];
  String[] opciones = new String[cantidadOpciones];
  cargarNombresDeTodosLosModificadores();
  cargarTodosLosModificadores();
  cargarOpciones();
}
void keyPressed() {
  if (key == ' ') pausa = !pausa;
  else if (keyCode == TAB) ciclo();
  else if (keyCode == BACKSPACE || keyCode == DELETE) reset();
  else if (key == 'f') fondoAlfa = !fondoAlfa;
  else if (key == 'd') sistema.debug = !sistema.debug;
}

void opciones() {
  mensaje_CANTIDAD("/opciones", cantidadOpciones);
  for (int i = 0 ; i< cantidadOpciones; i++) {
    mensaje_NOMBRE_ESTADO("/opciones", opciones[i], 0);
  }
  mensaje("/opciones/listo") ;
}

void modificadoresTotal() {
  mensaje_CANTIDAD("/modificadores/totales", cantidadModificadores);
  for (int i = 0 ; i< cantidadModificadores; i++) {
    mensaje_NOMBRE_ESTADO("/modificadores/totales", nombres[i], 0);
  }
  mensaje("/modificadores/listo");
}

void modificadoresExistentes() {
  mensaje_CANTIDAD("/modificadores/existentes", sistema.getCantidadModificadores());
  for (int i = 0 ; i< sistema.getCantidadModificadores(); i++) {
    mensaje_POSICION_ESTADO("/modificadores/existentes", i, sistema.getEstadoModificador(i)? 1 : 0);
  }
  mensaje("/modificadores/listo");
}

void modificadoresAgregar(String cual) {
  for (int i = 0; i<TodosLosModificadores.length;i++) {
    if (cual.equals(nombres[i])) sistema.agregarModificador(TodosLosModificadores[i]);
  }
}

void modificadoresQuitar(int cual) {
  sistema.eliminarModificador(cual);
  modificadoresExistentes();
}

void accionOpciones(String cual) {
  if (cual.equals("pausa")) pausa = !pausa;
  if (cual.equals("ciclo")) ciclo();
  if (cual.equals("reset")) reset();
  if (cual.equals("fondoAlfa")) fondoAlfa = !fondoAlfa;
  if (cual.equals("pausa")) sistema.debug = !sistema.debug;
}

void cargarNombresDeTodosLosModificadores() {
  nombres[0] = "mActualizarRastro";
  nombres[1]="mAlfaSegunVelocidad";
  nombres[2]="mAplicarFuerza";
  nombres[3]="mAtraccionAlCentro";
  nombres[4]="mColisionParticulasSimple";
  nombres[5]="mDibujar";
  nombres[6]="mEspacioCerrado";
  nombres[7]="mEspacioToroidal";
  nombres[8]="mFlockAlineamiento";
  nombres[9]="mFlockCohesion";
  nombres[10]="mFlockSeparacion";
  nombres[11]="mFuerzasPorSemejanza";
  nombres[12]="mGravedad";
  nombres[13]="mMover";
  nombres[14]="mRastroElastico";
  nombres[15]="mResetLluvia";
}

void cargarTodosLosModificadores() {
  TodosLosModificadores[0] = mActualizarRastro;
  TodosLosModificadores[1]=mAlfaSegunVelocidad;
  TodosLosModificadores[2]=mAplicarFuerza;
  TodosLosModificadores[3]=mAtraccionAlCentro;
  TodosLosModificadores[4]=mColisionParticulasSimple;
  TodosLosModificadores[5]=mDibujar;
  TodosLosModificadores[6]=mEspacioCerrado;
  TodosLosModificadores[7]=mEspacioToroidal;
  TodosLosModificadores[8]=mFlockAlineamiento;
  TodosLosModificadores[9]=mFlockCohesion;
  TodosLosModificadores[10]=mFlockSeparacion;
  TodosLosModificadores[11]=mFuerzasPorSemejanza;
  TodosLosModificadores[12]=mGravedad;
  TodosLosModificadores[13]=mMover;
  TodosLosModificadores[14]=mRastroElastico;
  TodosLosModificadores[15]=mResetLluvia;
}

void cargarOpciones() {
  opciones[0] = "pausa";
  opciones[1] = "ciclo";
  opciones[2] = "reset";
  opciones[3] = "fondoAlfa";
  opciones[4] = "sistema.debug";
}

void mensaje(String mensaje) {
  OscMessage mensajeModificadores ;
  mensajeModificadores = new OscMessage(mensaje);
  oscP5.send(mensajeModificadores, consola);
}

void mensaje_CANTIDAD(String mensaje, int cantidad) {
  OscMessage mensajeModificadores ;
  mensajeModificadores = new OscMessage(mensaje);
  mensajeModificadores.add(cantidad);
  oscP5.send(mensajeModificadores, consola);
}

void mensaje_NOMBRE_ESTADO(String mensaje, String nombre, int estado) {
  OscMessage mensajeModificadores ;
  mensajeModificadores = new OscMessage(mensaje);
  mensajeModificadores.add(nombre);
  mensajeModificadores.add(estado); // 0 para false   --- 1 para true // para evitar usar otra funcion agrego un dato de estado de las opciones luego peude serviar para revisar el estado dle alfa y al pausa por ejemplo
  oscP5.send(mensajeModificadores, consola);
}

void mensaje_POSICION_ESTADO(String mensaje, int posicion, int estado) {
  OscMessage mensajeModificadores ;
  mensajeModificadores = new OscMessage(mensaje);
  mensajeModificadores.add(posicion);
  mensajeModificadores.add(estado); // 0 para false   --- 1 para true // para evitar usar otra funcion agrego un dato de estado de las opciones luego peude serviar para revisar el estado dle alfa y al pausa por ejemplo
  oscP5.send(mensajeModificadores, consola);
}

