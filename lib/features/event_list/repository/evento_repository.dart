import 'dart:convert';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class EventoRepository {
  Future<List<Evento>> getEventos() async {
    var response = await API().get("evento");
    if (response is Success) {
      print(response.response);
      return eventosFromJSON(response.response as String);
    }
    if (response is Failure) {
      print(response.errorResponse);
      return [];
    }
    return [];
  }

  Future<Evento?> addEvento(String nome) async {
    var response = await API().post("evento", {
      "nome": nome,
    });

    if (response is Success) {
      // Map decoded = json.decode(response.response as String);
    }
    return null;
  }

  List<Evento> eventosFromJSON(String str) =>
      List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

  String eventosToJSON(List<Evento> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
