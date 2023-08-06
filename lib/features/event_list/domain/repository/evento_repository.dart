import 'dart:convert';

import '../../../../shared/utils/api.dart';
import '../../../../shared/utils/api_status.dart';
import '../models/evento.dart';

class EventoRepository {
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

  List<Evento> eventosFromJSON(String str) =>
      List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

  String eventosToJSON(List<Evento> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
