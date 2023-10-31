import 'dart:convert';
import 'dart:io';

import 'package:role/models/user.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class UserRepository {
  Future<User?> authenticate() async {
    try {
      final response = await API().request(endpoint: "usuario", method: "GET");

      Map decoded = json.decode(response.response);
      if (decoded.containsKey("user")) {
        return User.fromJson(decoded["user"]);
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

  Future<(User?, String?)> verify(String email, String code) async {
    try {
      final response = await API().request(
          endpoint: "usuario/verify",
          method: "POST",
          body: {"email": email, "code": code});

      Map decoded = json.decode(response.response);
      if (decoded.containsKey("user") && decoded.containsKey("token")) {
        return (User.fromJson(decoded["user"]), decoded["token"].toString());
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

  Future<int?> putUser(User user) async {
    try {
      final response = await API()
          .request(endpoint: "usuario", method: "PUT", body: user.toJson());

      return json.decode(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<String?> uploadImage(File image) async {
    try {
      final response = await API()
          .uploadFile(file: image, field: "profile", endpoint: "usuario/image");
      return jsonDecode(response.response)["url"];
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
