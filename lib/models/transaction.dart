import 'package:intl/intl.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/utils/serializable.dart';

class Transaction implements JSONSerializable {
  int _id;
  double? _valor;
  DateTime _data;
  User _user;
  int _itemId;

  Transaction({
    required int id,
    required double? valor,
    required DateTime data,
    required User user,
    required int itemId,
  })  : _id = id,
        _valor = valor,
        _data = data,
        _user = user,
        _itemId = itemId;

  int get id => _id;
  set id(int value) => _id = value;

  double? get valor => _valor;
  set valor(double? value) => _valor = value;

  DateTime get data => _data;
  set data(DateTime value) => _data = value;

  User get user => _user;
  set user(User value) => _user = value;

  int get itemId => _itemId;
  set itemId(int value) => _itemId = value;

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json["id_transacao"],
      valor: double.parse(json["valor"]),
      data: DateTime.parse(json["data"]),
      user: User.fromJson(json),
      itemId: json["insumos_id_insumo"]);

  @override
  Map<String, dynamic> toJson() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      "transactionId": id,
      "date": formatter.format(data),
      "amount": valor,
      "itemId": itemId
    };
  }
}
