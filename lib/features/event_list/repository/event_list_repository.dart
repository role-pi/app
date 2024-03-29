import 'dart:convert';
import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/models/event.dart';

class EventListRepository {
  Future<List<Event>> getEvents() async {
    try {
      var response = await API().request(endpoint: "event", method: "GET");
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
          await API().request(endpoint: "event/${event.id}", method: "DELETE");

      return json.decode(response.response)["affectedRows"] > 0;
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return false;
  }

  Future<int?> postEvent(Event event) async {
    try {
      var response = await API()
          .request(endpoint: "event", method: "POST", body: event.toJson());

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
