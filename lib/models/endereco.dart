class Endereco {
  int _cep;
  String _logradouro;
  String _bairro;
  String _cidade;
  String _pais;

  int get cep => _cep;
  set cep(int value) => _cep = value;

  String get logradouro => _logradouro;
  set logradouro(String value) => _logradouro = value;

  String get bairro => _bairro;
  set bairro(String value) => _bairro = value;

  String get cidade => _cidade;
  set cidade(String value) => _cidade = value;

  String get pais => _pais;
  set pais(String value) => _pais = value;

  Endereco({
    required int cep,
    required String logradouro,
    required String bairro,
    required String cidade,
    required String pais,
  })  : _cep = cep,
        _logradouro = logradouro,
        _bairro = bairro,
        _cidade = cidade,
        _pais = pais;
}