import 'dart:convert';

import 'package:role/models/item.dart';
import 'package:role/models/user.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/event.dart';

class EventDetailRepository {
  Future<Event?> getEvento(Event evento) async {
    try {
      var response =
          await API().request(endpoint: "evento/${evento.id}", method: "GET");

      return Event.fromJson(json.decode(response.response));
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<List<Item>> getItems(Event evento) async {
    try {
      var response =
          await API().request(endpoint: "insumo/${evento.id}", method: "GET");

      return itemsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<List<User>> getUsuarios(Event evento) async {
    try {
      var response =
          await API().request(endpoint: "usuario/${evento.id}", method: "GET");

      return usuariosFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  List<Item> itemsFromJSON(String str) =>
      List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

  List<User> usuariosFromJSON(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
