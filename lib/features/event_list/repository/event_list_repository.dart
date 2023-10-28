import 'dart:convert';

import 'package:role/models/event_theme.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/models/event.dart';

class EventListRepository {
  Future<List<Event>> getEvents() async {
    try {
      var response = await API().request(endpoint: "evento", method: "GET");
      print(response.response);
      return eventsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<bool> deleteEvent(Event event) async {
    try {
      var response =
          await API().request(endpoint: "evento/${event.id}", method: "DELETE");

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

  Future<int?> addEvent(Event event) async {
    try {
      var response =
          await API().request(endpoint: "evento", method: "POST", body: {
        "nome": event.name,
        "emoji": event.theme.emoji,
        "cor1": event.theme.color1.toHex(),
        "cor2": event.theme.color2.toHex(),
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

  List<Event> eventsFromJSON(String str) =>
      List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

  String eventsToJSON(List<Event> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
