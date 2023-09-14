import 'dart:convert';

import 'package:role/models/evento_theme.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class EventoListRepository {
  Future<List<Evento>> getEventos() async {
    var response = await API().get("evento");

    if (response is Success) {
      return eventosFromJSON(response.response as String);
    }

    if (response is Failure) {
      print(response.errorResponse);
      return [];
    }

    return [];
  }

  Future<int?> addEvento(Evento evento) async {
    var response = await API().post("evento", {
      "nome": evento.name,
      "emoji": evento.theme.emoji,
      "cor1": evento.theme.color1.toHex(),
      "cor2": evento.theme.color2.toHex(),
    });

    if (response is Success) {
      Map decoded = json.decode(response.response as String);
      return decoded["insertId"];
    }
    return null;
  }

  List<Evento> eventosFromJSON(String str) =>
      List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

  String eventosToJSON(List<Evento> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
