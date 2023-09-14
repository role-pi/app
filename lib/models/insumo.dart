import 'dart:math';
import 'package:role/models/transacao.dart';
import 'package:role/shared/utils/serializable.dart';

class Insumo implements JSONSerializable {
  late int _id;
  late double _valor;
  late int _tipo;
  late String _nome;
  late String _descricao;
  List<Transacao> transacoes = [];

  Insumo({
    required int id,
    required double valor,
    required int tipo,
    required String nome,
    required String descricao,
  })  : _id = id,
        _valor = valor,
        _tipo = tipo,
        _nome = nome,
        _descricao = descricao;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  double get valor => _valor;
  set valor(double value) {
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

  String get descricao => _descricao;
  set descricao(String value) {
    _descricao = value;
  }

  void addTransacao(Transacao transacao) {
    transacoes.add(transacao);
  }

  @override
  factory Insumo.fromJson(Map<String, dynamic> json) => Insumo(
      id: json["id_insumo"],
      nome: json["nome"],
      tipo: json["tipo"],
      descricao: json["descricao"],
      valor: 0);

  @override
  Map<String, dynamic> toJson() => {
        "id_insumo": id,
        "tipo": tipo,
        "nome": nome,
        "descricao": descricao,
        "valor": valor,
      };
}
