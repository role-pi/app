import 'dart:io';
import 'package:role/controllers/api_status.dart';
import 'package:role/models/evento.dart';
import 'package:role/utils/constants.dart';
import 'package:role/models/usuario.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<Object> getUsers() async {
    try {
      var response = await http.get(Uri.parse('${api}usuarios'));
      print(response.body);
      if (success == response.statusCode) {
        return Success(code: success, response: usersFromJson(response.body));
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
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getEventos() async {
    try {
      var response = await http.get(Uri.parse('${api}eventos'));
      print(response.body);
      if (success == response.statusCode) {
        return Success(code: success, response: eventosFromJSON(response.body));
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
      return Failure(code: unknownError, errorResponse: 'Unknown Error');
    }
  }
}
