abstract class Modificador {
  abstract void atributosObligatorios(Sistema s);
  void atributosOpcionales(Sistema s) {
  }
  abstract void ejecutar(Sistema s);

  void modificar(Sistema s) {
    atributosObligatorios(s);
    atributosOpcionales(s);
    ejecutar(s);
  }
}

