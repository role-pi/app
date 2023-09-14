import 'dart:convert';

import 'package:role/models/insumo.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class EventoDetailRepository {
  Future<List<Insumo>> getInsumos(Evento evento) async {
    var response = await API().get("insumo/${evento.id}");

    if (response is Success) {
      return insumosFromJSON(response.response as String);
    }

    if (response is Failure) {
      print(response.errorResponse);
      return [];
    }

    return [];
  }

  List<Insumo> insumosFromJSON(String str) =>
      List<Insumo>.from(json.decode(str).map((x) => Insumo.fromJson(x)));

  // String eventosToJSON(List<Evento> data) =>
  //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
