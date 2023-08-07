import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/shared/utils/constants.dart';
import 'package:http/http.dart' as http;

class API {
  static const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImlhdCI6MTY5MTM1MDgxNCwiZXhwIjoxNjkxNDM3MjE0fQ.50XUDb5jnIXx3LbcwxJ-QctSrs0Exv_FiOyA2PPXTMc";

  static const storage = FlutterSecureStorage();

  Future<Object> post(endpoint, data) async {
    var url = '${api}${endpoint}';

    // String? token = await storage.read(key: 'token');

    // if (token == null) {
    //   return Failure(code: userInvalidResponse, errorResponse: 'Invalid Token');
    // }

    var body = json.encode(data);

    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "JWT ${token}"
          },
          body: body);

      if (success == response.statusCode) {
        return Success(code: success, response: response.body);
      }

      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(code: noInternet, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Format');
    } catch (e) {
      print(e);
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  Future<Object> get(endpoint) async {
    var url = '${api}${endpoint}';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization": "JWT ${token}"
      });

      if (success == response.statusCode) {
        return Success(code: success, response: response.body);
      }

      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: noInternet, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(code: noInternet, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Format');
    } catch (e) {
      print(e);
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
