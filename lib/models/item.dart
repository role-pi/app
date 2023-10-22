import 'package:role/models/transaction.dart';
import 'package:role/shared/utils/serializable.dart';

class Item implements JSONSerializable {
  late int _id;
  late double _valor;
  late int _tipo;
  late String _nome;
  late String _descricao;
  late int _eventId;
  List<Transaction> transacoes = [];

  Item({
    required int id,
    required double valor,
    required int tipo,
    required String nome,
    required String descricao,
    required int eventId,
  })  : _id = id,
        _valor = valor,
        _tipo = tipo,
        _nome = nome,
        _descricao = descricao,
        _eventId = eventId;

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

  int get eventId => _eventId;
  set eventId(int value) {
    _eventId = value;
  }

  void addTransacao(Transaction transacao) {
    transacoes.add(transacao);
  }

  @override
  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json["id_insumo"],
      nome: json["nome"],
      tipo: json["tipo"],
      descricao: json["descricao"],
      valor: 0,
      eventId: 0);

  @override
  Map<String, dynamic> toJson() => {
        "idInsumo": id,
        "tipo": tipo,
        "nome": nome,
        "descricao": descricao,
        "valor": valor,
        "idEvento": eventId,
      };
}
