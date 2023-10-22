class Transaction {
  int _idTransacao;
  double _valor;
  DateTime _data;
  int _idUsuario;

  Transaction({
    required int idTransacao,
    required double valor,
    required DateTime data,
    required int idInsumo,
    required int idUsuario,
  })  : _idTransacao = idTransacao,
        _valor = valor,
        _data = data,
        _idUsuario = idUsuario;

  int get idTransacao => _idTransacao;
  set idTransacao(int value) => _idTransacao = value;

  double get valor => _valor;
  set valor(double value) => _valor = value;

  DateTime get data => _data;
  set data(DateTime value) => _data = value;

  int get idUsuario => _idUsuario;
  set idUsuario(int value) => _idUsuario = value;
}
