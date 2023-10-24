import 'package:role/models/transaction.dart';
import 'package:role/shared/utils/serializable.dart';

class Item implements JSONSerializable {
  late int _id;
  late double? _valor;
  late ItemCategory _tipo;
  late String _nome;
  late String _descricao;
  late int _eventId;
  List<Transaction> transacoes = [];

  Item({
    required int id,
    required double? valor,
    required ItemCategory tipo,
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

  double? get valor => _valor;
  set valor(double? value) {
    _valor = value;
  }

  ItemCategory get tipo => _tipo;
  set tipo(ItemCategory value) {
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
      tipo: ItemCategory.fromValue(json["tipo"]),
      descricao: json["descricao"],
      valor: 0,
      eventId: 0);

  @override
  Map<String, dynamic> toJson() => {
        "idInsumo": id,
        "tipo": tipo.value,
        "nome": nome,
        "descricao": descricao,
        "valor": valor,
        "idEvento": eventId,
      };
}

enum ItemCategory {
  other,
  ticket,
  transportation,
  food,
  beverages;

  int get value {
    switch (this) {
      case ItemCategory.ticket:
        return 1;
      case ItemCategory.transportation:
        return 2;
      case ItemCategory.food:
        return 3;
      case ItemCategory.beverages:
        return 4;
      default:
        return 0;
    }
  }

  static ItemCategory fromValue(value) {
    switch (value) {
      case 1:
        return ItemCategory.ticket;
      case 2:
        return ItemCategory.transportation;
      case 3:
        return ItemCategory.food;
      case 4:
        return ItemCategory.beverages;
      default:
        return ItemCategory.other;
    }
  }

  String get name {
    switch (this) {
      case ItemCategory.ticket:
        return "Ingressos";
      case ItemCategory.transportation:
        return "Transporte";
      case ItemCategory.food:
        return "Comidas";
      case ItemCategory.beverages:
        return "Bebidas";
      default:
        return "Outros";
    }
  }

  String get emoji {
    switch (this) {
      case ItemCategory.ticket:
        return "🎟️";
      case ItemCategory.transportation:
        return "🚕";
      case ItemCategory.food:
        return "🌮";
      case ItemCategory.beverages:
        return "🧃";
      default:
        return "✨";
    }
  }
}
