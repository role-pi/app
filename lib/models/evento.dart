import 'dart:convert';

class Evento {
  Evento({required this.id, required this.name, this.dataInicio, this.dataFim});
  // required this.idUsuarios,
  // required this.idInsumos});

  int id;
  String name;
  DateTime? dataInicio;
  DateTime? dataFim;
  // List<int> idUsuarios;
  // List<int> idInsumos;

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        id: json["id_evento"],
        name: json["nome"],
        dataInicio: DateTime.parse(json["data_inicio"]),
        dataFim: DateTime.parse(json["data_fim"]),
        // idUsuarios: json["id_usuarios"],
        // idInsumos: json["id_insumos"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dataInicio": dataInicio?.toIso8601String(),
        "dataFim": dataFim?.toIso8601String(),
        // "id_usuarios": idUsuarios,
        // "id_insumis": idInsumos
      };
}

List<Evento> eventosFromJSON(String str) =>
    List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

String eventosToJSON(List<Evento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
