import 'dart:convert';
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
  double? _totalAmount;
  List<String>? _profilePictures;
  EventTheme _theme;
  Location _location;

  late List<Item>? _items = null;
  late List<User>? _users = null;

  Event(
      {required int id,
      required String name,
      DateTime? startDate,
      DateTime? endDate,
      double? totalAmount,
      List<String>? profilePictures,
      EventTheme? theme,
      Location? location})
      : _id = id,
        _name = name,
        _startDate = startDate,
        _endDate = endDate,
        _totalAmount = totalAmount,
        _profilePictures = profilePictures,
        _theme = theme ?? EventTheme.random(),
        _location = location ??
            Location(
                latitude: -26.905926949896116,
                longitude: -49.07710147997988,
                descricao: "IFSC Campus gaspar");

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

  double? get totalAmount => _totalAmount;
  set totalAmount(double? value) {
    _totalAmount = value;
  }

  List<String>? get profilePictures => _profilePictures;
  set profilePictures(List<String>? value) {
    _profilePictures = value;
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

  Location get location => _location;
  set location(Location value) {
    _location = value;
  }

  @override
  factory Event.fromJson(Map<String, dynamic> json) {
    Location? location;

    if (json.containsKey("location")) {
      var locationJson = json["location"];
      if (locationJson != null) {
        location = Location(
            latitude: locationJson["x"],
            longitude: locationJson["y"],
            descricao: json["location_description"]);
      }
    }

    return Event(
        id: json["id_evento"],
        name: json["nome"],
        startDate: json["data_inicio"] != null
            ? DateTime.parse(json["data_inicio"])
            : null,
        endDate:
            json["data_fim"] != null ? DateTime.parse(json["data_fim"]) : null,
        totalAmount: double.parse(json["valor_total"]),
        profilePictures: json["fotos_de_perfil"] != null
            ? json["fotos_de_perfil"].toString().split(', ')
            : [],
        theme: EventTheme.fromHex(
            emoji: json["emoji"], hex1: json["cor_1"], hex2: json["cor_2"]),
        location: location);
  }

  @override
  Map<String, dynamic> toJson() {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return {
      "eventId": id,
      "name": name,
      "startDate": startDate != null ? formatter.format(startDate!) : "",
      "endDate": endDate != null ? formatter.format(endDate!) : "",
      "emoji": theme.emoji,
      "color1": theme.color1.toHex(),
      "color2": theme.color2.toHex(),
      "location_lat": location.latitude,
      "location_lng": location.longitude,
      "location_description": location.descricao
    };
  }

  String get emoji => theme.emoji;
  Color get color1 => theme.color1;
  Color get color2 => theme.color2;

  String get shortDescription {
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

    return usersString;
  }

  String get usersString {
    int amount = users?.length ?? profilePictures?.length ?? 0;

    if (amount == 0) {
      return 'Nenhum participante';
    } else if (amount == 1) {
      return '1 participante';
    } else {
      return '$amount participantes';
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
