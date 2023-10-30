import 'dart:math';

import 'package:intl/intl.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/utils/serializable.dart';

class Item implements JSONSerializable {
  late int _id;
  late double? _amount;
  late ItemCategory _category;
  late String _name;
  late String _notes;
  late DateTime _date;
  late int _eventId;
  List<Transaction> _transactions = [];

  Item({
    required int id,
    required double? amount,
    required ItemCategory category,
    required String name,
    required String notes,
    required DateTime date,
    required int eventId,
  })  : _id = id,
        _amount = amount,
        _category = category,
        _name = name,
        _notes = notes,
        _date = date,
        _eventId = eventId;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  double? get amount => _amount;
  set amount(double? value) {
    _amount = value;
  }

  ItemCategory get category => _category;
  set category(ItemCategory value) {
    _category = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get notes => _notes;
  set notes(String value) {
    _notes = value;
  }

  DateTime get date => _date;
  set date(DateTime value) {
    _date = value;
  }

  int get eventId => _eventId;
  set eventId(int value) {
    _eventId = value;
  }

  List<Transaction> get transactions => _transactions;
  set transactions(List<Transaction> value) {
    _transactions = value;
  }

  @override
  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json["id_insumo"],
      name: json["nome"],
      category: ItemCategory.fromValue(json["tipo"]),
      notes: json["descricao"],
      date: DateTime.now().add(Duration(hours: -Random().nextInt(24 * 5))),
      amount: double.parse(json["valor_total"]),
      eventId: 0);

  @override
  Map<String, dynamic> toJson() => {
        "idInsumo": id,
        "tipo": category.value,
        "nome": name,
        "descricao": notes,
        "valor": amount,
        "idEvento": eventId,
      };

  String get dayDescription {
    if (date.day == DateTime.now().day) {
      return "hoje";
    } else if (date.day == DateTime.now().add(Duration(days: -1)).day) {
      return "ontem";
    } else {
      final formatador = DateFormat("dd 'de' MMMM", 'pt_BR');
      return formatador.format(date);
    }
  }
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
