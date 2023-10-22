import 'dart:convert';

import 'package:role/models/event_theme.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/event.dart';

class EventoListRepository {
  Future<List<Event>> getEventos() async {
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

  Future<bool> deleteEvento(Event evento) async {
    try {
      var response = await API()
          .request(endpoint: "evento/${evento.id}", method: "DELETE");

      print(response.response);
      return true;
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return false;
  }

  Future<int?> addEvento(Event evento) async {
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

  List<Event> eventosFromJSON(String str) =>
      List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

  String eventosToJSON(List<Event> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
