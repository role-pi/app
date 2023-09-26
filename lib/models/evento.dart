import 'dart:ffi';
import 'dart:math';
import 'dart:ui';
import 'package:role/models/endereco.dart';
import 'package:role/models/evento_theme.dart';
import 'package:role/models/insumo.dart';
import 'package:role/models/usuario.dart';
import 'package:role/shared/utils/serializable.dart';
import 'package:intl/intl.dart';

class Evento implements JSONSerializable {
  int _id;
  String _name;
  DateTime? _dataInicio;
  DateTime? _dataFim;
  double? _valorTotal;
  EventoTheme _theme;

  late List<Insumo>? _insumos = null;
  late List<Usuario>? _usuarios = null;

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

  List<Insumo>? get insumos => _insumos;
  set insumos(List<Insumo>? value) {
    _insumos = value;
  }

  List<Usuario>? get usuarios => _usuarios;
  set usuarios(List<Usuario>? value) {
    _usuarios = value;
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
        "idEvento": id,
        "nome": name,
        "dataInicio": dataInicio?.toIso8601String(),
        "dataFim": dataFim?.toIso8601String(),
        "valorTotal": valorTotal,
        "emoji": theme.emoji,
        "cor1": theme.color1.toHex(),
        "cor2": theme.color2.toHex(),
      };

  String get emoji => theme.emoji;
  Color get color1 => theme.color1;
  Color get color2 => theme.color2;

  Endereco get endereco => Endereco(
      latitude: -26.905926949896116,
      longitude: -49.07710147997988,
      descricao: "Factory Antônio da Veiga");

  String get shortDescription {
    int participantes = 2;
    final now = DateTime.now();
    Duration? difference;

    bool ongoing = false;

    if (dataFim != null && now.isAfter(dataFim!)) {
      return 'Concluído';
    }

    if (dataInicio != null &&
        dataFim != null &&
        now.isAfter(dataInicio!) &&
        now.isBefore(dataFim!)) {
      difference = dataFim!.difference(now);
      ongoing = true;
    } else if (dataInicio != null) {
      difference = dataInicio!.difference(now);
      if (now.isAfter(dataInicio!)) {
        ongoing = true;
      }
    } else if (dataFim != null) {
      difference = dataFim!.difference(now);
      ongoing = true;
    }

    String? time = null;
    if (difference != null) {
      difference = difference.abs();

      if (difference.inDays > 0) {
        time = '${difference.inDays} dia${difference.inDays == 1 ? '' : 's'}';
      } else if (difference.inHours > 0) {
        time =
            '${difference.inHours} hora${difference.inHours == 1 ? '' : 's'}';
      } else if (difference.inMinutes > 0) {
        time =
            '${difference.inMinutes} minuto${difference.inMinutes == 1 ? '' : 's'}';
      } else if (difference.inSeconds > 0) {
        time =
            '${difference.inSeconds} segundo${difference.inSeconds == 1 ? '' : 's'}';
      }
    }

    if (time != null) {
      return ongoing
          ? (dataFim != null ? 'Termina em $time' : 'Começou há $time')
          : 'Começa em $time';
    }

    if (participantes == 0 || participantes == 1) {
      return 'Um convidado';
    } else if (participantes == 2) {
      return '1 convidado';
    } else {
      return '${participantes - 1} convidados';
    }
  }

  String get dateDescription {
    if (dataInicio == null || dataFim == null) {
      return '';
    }

    final DateFormat dayMonthFormat = DateFormat("d 'de' MMMM", 'pt_BR');
    final DateFormat hourMinuteFormat = DateFormat('HH:mm');

    final String startFormatted = dayMonthFormat.format(dataInicio!);
    final String endFormatted =
        dataFim != null ? dayMonthFormat.format(dataFim!) : '';
    final String startHour = hourMinuteFormat.format(dataInicio!);
    final String endHour =
        dataFim != null ? hourMinuteFormat.format(dataFim!) : '';

    if (dataFim != null) {
      if (dataFim!.day - dataInicio!.day <= 1) {
        return '$startFormatted, $startHour – $endHour';
      } else if (dataInicio!.month == dataFim!.month) {
        return 'de ${dataInicio!.day} a $endFormatted';
      } else {
        return 'de $startFormatted a $endFormatted';
      }
    } else {
      return '$startFormatted, às $startHour';
    }
  }
}
