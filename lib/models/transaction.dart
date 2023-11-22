import 'package:intl/intl.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/utils/serializable.dart';

class Transaction implements JSONSerializable {
  int _id;
  double? _amount;
  DateTime _date;
  User _user;
  int _itemId;

  Transaction({
    required int id,
    required double? amount,
    required DateTime date,
    required User user,
    required int itemId,
  })  : _id = id,
        _amount = amount,
        _date = date,
        _user = user,
        _itemId = itemId;

  int get id => _id;
  set id(int value) => _id = value;

  double? get amount => _amount;
  set amount(double? value) => _amount = value;

  DateTime get date => _date;
  set date(DateTime value) => _date = value;

  User get user => _user;
  set user(User value) => _user = value;

  int get itemId => _itemId;
  set itemId(int value) => _itemId = value;

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json["id_transacao"],
      amount: double.parse(json["valor"]),
      date: DateTime.parse(json["data"]),
      user: User.fromJson(json),
      itemId: json["insumos_id_insumo"]);

  @override
  Map<String, dynamic> toJson() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      "transactionId": id,
      "date": formatter.format(date),
      "amount": amount,
      "newUserId": user.id,
      "itemId": itemId
    };
  }
}
