class Transacao {

  int idTransacao;
  double valor;
  DateTime data;
  int idInsumo;
  int idUsuario;

  Transacao({
    required this.idTransacao,
    required this.valor,
    required this.data,
    required this.idInsumo,
    required this.idUsuario,
  });
}
