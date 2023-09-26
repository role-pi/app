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
}
