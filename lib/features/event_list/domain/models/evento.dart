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
        dataInicio: json["data_inicio"] != null
            ? DateTime.parse(json["data_inicio"])
            : null,
        dataFim:
            json["data_fim"] != null ? DateTime.parse(json["data_fim"]) : null,
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
