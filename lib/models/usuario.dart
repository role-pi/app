class Usuario {
  Usuario(
      {required this.id, this.name, required this.email, this.profilePhoto});

  int id;
  String? name;
  String email;
  String? profilePhoto;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profilePhoto: json["profilePhoto"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id == null ? null : id,
  //       "name": name == null ? null : name,
  //       "username": username == null ? null : username,
  //       "email": email == null ? null : email,
  //       "address": address == null ? null : address.toJson(),
  //       "phone": phone == null ? null : phone,
  //       "website": website == null ? null : website,
  //       "company": company == null ? null : company.toJson(),
  //     };
}
