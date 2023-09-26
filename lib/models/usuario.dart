import 'dart:convert';
import 'package:role/shared/utils/serializable.dart';

class Usuario implements JSONSerializable {
  int _id;
  String? _name;
  String _email;
  String? _profilePhoto;

  Usuario({
    required int id,
    String? name,
    required String email,
    String? profilePhoto,
  })  : _id = id,
        _name = name,
        _email = email,
        _profilePhoto = profilePhoto;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String? get profilePhoto => _profilePhoto;
  set profilePhoto(String? value) {
    _profilePhoto = value;
  }

  String get displayName => _name ?? _email;

  @override
  Map<String, dynamic> toJson() => {
        "idUsuario": _id,
        "nome": _name,
        "email": _email,
        "profilePhoto": _profilePhoto,
      };

  @override
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id_usuario"],
        name: json["nome"],
        email: json["email"],
        profilePhoto: json["foto_de_perfil_url"],
      );
}

List<Usuario> usersFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usersToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
