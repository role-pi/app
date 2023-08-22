import 'dart:math';
import 'transacao.dart';

class Insumo {
  late double valor;

  Insumo() {
    // random between 100 and 250
    valor = Random().nextInt(150) + 100;
  }

  int idInsumo;
  int tipo;
  String nome;
  int idEvento;
  List<Transacao> transacoes = [];

  Insumo({
    required this.idInsumo,
    required this.tipo,
    required this.nome,
    required this.idEvento,
  });

  void addTransacao(Transacao transacao) {
    transacoes.add(transacao);
  }
}
