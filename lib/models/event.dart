import 'dart:ui';
import 'package:role/models/location.dart';
import 'package:role/models/event_theme.dart';
import 'package:role/models/item.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/utils/serializable.dart';
import 'package:intl/intl.dart';

class Event implements JSONSerializable {
  int _id;
  String _name;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _valorTotal;
  EventTheme _theme;

  late List<Item>? _items = null;
  late List<User>? _users = null;

  Event({
    required int id,
    required String name,
    DateTime? startDate,
    DateTime? endDate,
    double? valorTotal,
    EventTheme? theme,
  })  : _id = id,
        _name = name,
        _startDate = startDate,
        _endDate = endDate,
        _valorTotal = valorTotal,
        _theme = theme ?? EventTheme.random();

  int get id => _id;

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  DateTime? get startDate => _startDate;
  set startDate(DateTime? value) {
    _startDate = value;
  }

  DateTime? get endDate => _endDate;
  set endDate(DateTime? value) {
    _endDate = value;
  }

  double? get valorTotal => _valorTotal;
  set valorTotal(double? value) {
    _valorTotal = value;
  }

  EventTheme get theme => _theme;
  set theme(EventTheme value) {
    _theme = value;
  }

  List<Item>? get items => _items;
  set items(List<Item>? value) {
    _items = value;
  }

  List<User>? get users => _users;
  set users(List<User>? value) {
    _users = value;
  }

  @override
  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json["id_evento"],
      name: json["nome"],
      startDate: json["data_inicio"] != null
          ? DateTime.parse(json["data_inicio"])
          : null,
      endDate:
          json["data_fim"] != null ? DateTime.parse(json["data_fim"]) : null,
      valorTotal: double.parse(json["valor_total"]),
      theme: EventTheme.fromHex(
          emoji: json["emoji"], hex1: json["cor_1"], hex2: json["cor_2"]));

  @override
  Map<String, dynamic> toJson() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      "idEvento": id,
      "nome": name,
      "dataInicio": startDate != null ? formatter.format(startDate!) : "",
      "dataFim": endDate != null ? formatter.format(endDate!) : "",
      "emoji": theme.emoji,
      "cor1": theme.color1.toHex(),
      "cor2": theme.color2.toHex(),
    };
  }

  String get emoji => theme.emoji;
  Color get color1 => theme.color1;
  Color get color2 => theme.color2;

  Location get endereco => Location(
      latitude: -26.905926949896116,
      longitude: -49.07710147997988,
      descricao: "Factory Antônio da Veiga");

  String get shortDescription {
    int participantes = 2;
    final now = DateTime.now();
    Duration? difference;

    bool ongoing = false;

    if (endDate != null && now.isAfter(endDate!)) {
      return 'Concluído';
    }

    if (startDate != null &&
        endDate != null &&
        now.isAfter(startDate!) &&
        now.isBefore(endDate!)) {
      difference = endDate!.difference(now);
      ongoing = true;
    } else if (startDate != null) {
      difference = startDate!.difference(now);
      if (now.isAfter(startDate!)) {
        ongoing = true;
      }
    } else if (endDate != null) {
      difference = endDate!.difference(now);
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
          ? (endDate != null ? 'Termina em $time' : 'Começou há $time')
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
    if (startDate == null || endDate == null) {
      return '';
    }

    final DateFormat dayMonthFormat = DateFormat("d 'de' MMMM", 'pt_BR');
    final DateFormat hourMinuteFormat = DateFormat('HH:mm');

    final String startFormatted = dayMonthFormat.format(startDate!);
    final String endFormatted =
        endDate != null ? dayMonthFormat.format(endDate!) : '';
    final String startHour = hourMinuteFormat.format(startDate!);
    final String endHour =
        endDate != null ? hourMinuteFormat.format(endDate!) : '';

    if (endDate != null) {
      if (endDate!.day - startDate!.day <= 1) {
        return '$startFormatted, $startHour – $endHour';
      } else if (startDate!.month == endDate!.month) {
        return 'de ${startDate!.day} a $endFormatted';
      } else {
        return 'de $startFormatted a $endFormatted';
      }
    } else {
      return '$startFormatted, às $startHour';
    }
  }
}
