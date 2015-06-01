class formaCerrado {
  float radioInfluenciaTorso;
  float distMaxPiernas;
  PVector torso;
  PVector pierna1;
  PVector pierna2;
  PVector brazo1;
  PVector brazo2;
  public boolean enterCerrado=false;
  public boolean exitCerrado = false;
  public boolean stayCerrado=false;

  formaCerrado( PVector torso, PVector pierna1, PVector pierna2, PVector brazo1, PVector brazo2, float distMaxPiernas, float radioInfluenciaTorso) {
    //acá en vez de asignar los pvectors, se podría hacer una referencia al torso, pierna, etc que se verifiquen a nivel sistema, para tener en todo momento los datos actualizados de la pos
    //de cada una de esas partes y no tener que andar actualizándolos en esta clase, o pasándoselos como parámetros.
    this.torso = torso;
    this.pierna1=pierna1;
    this.pierna2=pierna2;
    this.brazo1=brazo1;
    this.brazo2=brazo2;
  }

  boolean checkDistMax(PVector uno, PVector otro, float distMax) {
    if (dist(uno.x, uno.y, otro.x, otro.y) < dist(uno.x, uno.y, uno.x + distMax, uno.y + distMax)) {
      return true;
    } else {
      return false;
    }
  }

  void actualizar(PVector torso, PVector pierna1, PVector pierna2, PVector brazo1, PVector brazo2 ) {
    if (checkDistMax(torso, brazo1, radioInfluenciaTorso) &&
      checkDistMax(torso, brazo2, radioInfluenciaTorso) &&
      checkDistMax(pierna1, pierna2, distMaxPiernas)) {

      if (enterCerrado == false && stayCerrado == false) {
        enterCerrado = true;
      } else {
        enterCerrado = false;
      }
      stayCerrado = true;
      exitCerrado = false;
    } else {
      if (exitCerrado == false && stayCerrado == true) {
        exitCerrado = true;
      } else {
        exitCerrado = false;
      }
      stayCerrado = false;
      enterCerrado = false;
    }
  }
}
