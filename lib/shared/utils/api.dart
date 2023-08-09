import 'dart:convert';
import 'dart:io';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/shared/utils/constants.dart';
import 'package:http/http.dart' as http;

class API {
  static String get token => UserLoginProvider.shared.token ?? "";

  Future<Object> post(endpoint, data) async {
    var url = '${api}${endpoint}';

    // if (token.isEmpty) {
    //   return Failure(code: userInvalidResponse, errorResponse: 'Logged out');
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
          code: userInvalidResponse, errorResponse: 'Invalid response');
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
