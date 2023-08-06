import 'dart:convert';

class Usuario {
  Usuario(
      {required this.id, this.name, required this.email, this.profilePhoto});

  int id;
  String? name;
  String email;
  String? profilePhoto;

  String get displayName => name ?? email;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id_usuario"],
        name: json["nome"],
        email: "test@email.com",
        profilePhoto: json["foto_de_perfil_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profilePhoto": profilePhoto,
      };
}

List<Usuario> usersFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usersToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
