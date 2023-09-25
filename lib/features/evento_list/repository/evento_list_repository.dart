import 'dart:convert';

import 'package:role/models/evento_theme.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class EventoListRepository {
  Future<List<Evento>> getEventos() async {
    try {
      var response = await API().request(endpoint: "evento", method: "GET");

      return eventosFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<int?> addEvento(Evento evento) async {
    try {
      var response =
          await API().request(endpoint: "evento", method: "POST", body: {
        "nome": evento.name,
        "emoji": evento.theme.emoji,
        "cor1": evento.theme.color1.toHex(),
        "cor2": evento.theme.color2.toHex(),
      });

      Map decoded = json.decode(response.response);
      return decoded["insertId"];
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  List<Evento> eventosFromJSON(String str) =>
      List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

  String eventosToJSON(List<Evento> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
