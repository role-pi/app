import 'dart:math';

import 'package:role/models/transacao.dart';

class Insumo {
  late int valor;
  late int idInsumo;
  late int tipo;
  late String nome;
  late int idEvento;
  List<Transacao> transacoes = [];

  Insumo({
    valor = Random().nextInt(150) + 100;
    required this.idInsumo,
    required this.tipo,
    required this.nome,
    required this.idEvento,
  });

  void addTransacao(Transacao transacao) {
    transacoes.add(transacao);
  }
}
