class Usuario {
  Usuario(
      {required this.id,
      this.name,
      this.fotoDePerfil,
      required this.email,
      required this.token});

  int id;
  String? name;
  String? fotoDePerfil;
  String email;
  String token;

  // factory Evento.fromJson(Map<String, dynamic> json) => Evento(
  //       id: json["id_evento"],
  //       name: json["nome"],
  //       dataInicio: DateTime.parse(json["data_inicio"]),
  //       dataFim: DateTime.parse(json["data_fim"]),
  //       // idUsuarios: json["id_usuarios"],
  //       // idInsumos: json["id_insumos"]
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "dataInicio": dataInicio?.toIso8601String(),
  //       "dataFim": dataFim?.toIso8601String(),
  //       // "id_usuarios": idUsuarios,
  //       // "id_insumis": idInsumos
  //     };
}
