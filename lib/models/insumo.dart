import 'dart:math';

class Insumo {
  late int valor;

  Insumo() {
    // random between 100 and 250
    valor = Random().nextInt(150) + 100;
  }
}
