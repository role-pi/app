import 'package:intl/intl.dart';
import 'package:role/shared/utils/serializable.dart';

class Transaction implements JSONSerializable {
  int _id;
  double _valor;
  DateTime _data;
  String _userName;
  String? _userProfilePicture;
  int _userId;
  int _itemId;

  Transaction({
    required int id,
    required double valor,
    required DateTime data,
    required String userName,
    required String? userProfilePicture,
    required int userId,
    required int itemId,
  })  : _id = id,
        _valor = valor,
        _data = data,
        _userName = userName,
        _userProfilePicture = userProfilePicture,
        _userId = userId,
        _itemId = itemId;

  int get id => _id;
  set id(int value) => _id = value;

  double get valor => _valor;
  set valor(double value) => _valor = value;

  DateTime get data => _data;
  set data(DateTime value) => _data = value;

  String get userName => _userName;
  set userName(String value) => _userName = value;

  String? get userProfilePicture => _userProfilePicture;
  set userProfilePicture(String? value) => _userProfilePicture = value;

  int get userId => _userId;
  set userId(int value) => _userId = value;

  int get itemId => _itemId;
  set itemId(int value) => _itemId = value;

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json["id_transacao"],
      valor: double.parse(json["valor"]),
      data: DateTime.parse(json["data"]),
      userName: json["nome"],
      userProfilePicture: json["foto_de_perfil_url"],
      userId: json["id_usuario"],
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
