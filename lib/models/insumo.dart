import 'dart:math';
import 'package:role/models/transacao.dart';

class Insumo {
  late int _id;
  late int _valor;
  late int _tipo;
  late String _nome;
  late int _idEvento;
  List<Transacao> transacoes = [];

  Insumo({
    required int id,
    required int tipo,
    required String nome,
    required int idEvento,
  })  : _id = id,
        _tipo = tipo,
        _nome = nome,
        _idEvento = idEvento,
        _valor = Random().nextInt(150) + 100;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  int get valor => _valor;
  set valor(int value) {
    _valor = value;
  }

  int get tipo => _tipo;
  set tipo(int value) {
    _tipo = value;
  }

  String get nome => _nome;
  set nome(String value) {
    _nome = value;
  }

  int get idEvento => _idEvento;
  set idEvento(int value) {
    _idEvento = value;
  }

  void addTransacao(Transacao transacao) {
    transacoes.add(transacao);
  }
}
