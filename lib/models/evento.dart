import 'dart:ui';
import 'package:role/models/endereco.dart';
import 'package:role/models/evento_theme.dart';
import 'package:role/shared/utils/serializable.dart';

class Evento implements JSONSerializable {
  int _id;
  String _name;
  DateTime? _dataInicio;
  DateTime? _dataFim;
  double? _valorTotal;
  EventoTheme _theme;

  Evento({
    required int id,
    required String name,
    DateTime? dataInicio,
    DateTime? dataFim,
    double? valorTotal,
    EventoTheme? theme,
  })  : _id = id,
        _name = name,
        _dataInicio = dataInicio,
        _dataFim = dataFim,
        _valorTotal = valorTotal,
        _theme = theme ?? EventoTheme.random();

  int get id => _id;

  double? get latitude => null;

  double? get longitude => null;
  set id(int value) {
    _id = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  DateTime? get dataInicio => _dataInicio;
  set dataInicio(DateTime? value) {
    _dataInicio = value;
  }

  DateTime? get dataFim => _dataFim;
  set dataFim(DateTime? value) {
    _dataFim = value;
  }

  double? get valorTotal => _valorTotal;
  set valorTotal(double? value) {
    _valorTotal = value;
  }

  EventoTheme get theme => _theme;
  set theme(EventoTheme value) {
    _theme = value;
  }

  @override
  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
      id: json["id_evento"],
      name: json["nome"],
      dataInicio: json["data_inicio"] != null
          ? DateTime.parse(json["data_inicio"])
          : null,
      dataFim:
          json["data_fim"] != null ? DateTime.parse(json["data_fim"]) : null,
      valorTotal: double.parse(json["valor_total"]),
      theme: EventoTheme.fromHex(
          emoji: json["emoji"], hex1: json["cor_1"], hex2: json["cor_2"]));

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dataInicio": dataInicio?.toIso8601String(),
        "dataFim": dataFim?.toIso8601String(),
        "valorTotal": valorTotal,
      };

  String get emoji => theme.emoji;
  Color get color1 => theme.color1;
  Color get color2 => theme.color2;

  Endereco get endereco => Endereco(
      latitude: -26.905926949896116,
      longitude: -49.07710147997988,
      descricao: "Factory Antônio da Veiga");
}
