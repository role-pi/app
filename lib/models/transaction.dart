class Transaction {
  int _id;
  double _valor;
  DateTime _data;
  int _userId;

  Transaction({
    required int id,
    required double valor,
    required DateTime data,
    required int itemId,
    required int userId,
  })  : _id = id,
        _valor = valor,
        _data = data,
        _userId = userId;

  int get id => _id;
  set id(int value) => _id = value;

  double get valor => _valor;
  set valor(double value) => _valor = value;

  DateTime get data => _data;
  set data(DateTime value) => _data = value;

  int get userId => _userId;
  set userId(int value) => _userId = value;
}
