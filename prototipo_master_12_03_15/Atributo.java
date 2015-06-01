abstract class Atributo {
  abstract Atributo soloPonerNewX();
  abstract Atributo[] soloPonerNewArray(int tam);
  abstract Atributo[] iniciar(Sistema s, Atributo[] n);
  abstract String getKey();

  Atributo[] generarGrupo(Sistema s) {
    Atributo[] nuevas = soloPonerNewArray(s.tamano);
    nuevas[0] = this;
    for (int i=1; i<nuevas.length; i++) {
      nuevas[i] = soloPonerNewX();
    }
    return iniciar(s, nuevas);
  }
}

