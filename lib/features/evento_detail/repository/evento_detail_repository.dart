import 'dart:convert';

import 'package:role/models/insumo.dart';
import 'package:role/models/usuario.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class EventoDetailRepository {
  Future<Evento?> getEvento(Evento evento) async {
    try {
      var response =
          await API().request(endpoint: "evento/${evento.id}", method: "GET");

      return Evento.fromJson(json.decode(response.response));
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<List<Insumo>> getInsumos(Evento evento) async {
    try {
      var response =
          await API().request(endpoint: "insumo/${evento.id}", method: "GET");

      return insumosFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<List<Usuario>> getUsuarios(Evento evento) async {
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

  Future<bool> updateEvento(Evento evento) async {
    try {
      await API().request(endpoint: "insumo/${evento.id}", method: "PUT");

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

  List<Insumo> insumosFromJSON(String str) =>
      List<Insumo>.from(json.decode(str).map((x) => Insumo.fromJson(x)));

  List<Usuario> usuariosFromJSON(String str) =>
      List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));
}
