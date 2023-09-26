import 'dart:convert';

import 'package:role/models/usuario.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';

class UserRepository {
  Future<Usuario?> authenticate() async {
    try {
      final response =
          await API().request(endpoint: "usuario/login", method: "POST");

      Map decoded = json.decode(response.response);
      if (decoded.containsKey("user")) {
        return Usuario.fromJson(decoded["user"]);
      }
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<bool?> signUp(String email) async {
    try {
      final response = await API().request(
          endpoint: "usuario/signin", method: "POST", body: {"email": email});

      Map decoded = json.decode(response.response);
      if (decoded.containsKey("existing")) {
        return decoded["existing"];
      }
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<(Usuario?, String?)> verify(String email, String code) async {
    try {
      final response = await API().request(
          endpoint: "usuario/verify",
          method: "POST",
          body: {"email": email, "code": code});

      Map decoded = json.decode(response.response);
      if (decoded.containsKey("user") && decoded.containsKey("token")) {
        return (Usuario.fromJson(decoded["user"]), decoded["token"].toString());
      }
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return (null, null);
  }
}
