import 'dart:io';
import 'package:role/controllers/api_status.dart';
import 'package:role/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<Object> getUsers() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (success == response.statusCode) {
        // return Success(response: usersListModelFromJson(response.body));
      }
      return Failure(
          code: userInvalidResponse, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: noInternet, errorResponse: 'No Internet          Connection');
    } on SocketException {
      return Failure(code: noInternet, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: invalidFormat, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
