import 'dart:convert';
import 'dart:io';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:http/http.dart' as http;
import 'package:role/shared/utils/constants.dart';

class API {
  static String get token => UserLoginProvider.shared.token ?? "";

  Future<ApiResponse> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    bool auth = true,
    dynamic body,
    int success = 200,
    String customErrorMessage = 'Unknown Error',
  }) async {
    try {
      http.Response response;

      headers = headers ?? {"Content-Type": "application/json"};

      if (auth) {
        headers.addAll({"Authorization": "JWT ${token}"});
      }

      String url = '${api}${endpoint}';

      switch (method) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case 'POST':
          response =
              await http.post(Uri.parse(url), headers: headers, body: body);
          break;
        case 'PUT':
          response =
              await http.put(Uri.parse(url), headers: headers, body: body);
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
        default:
          throw ApiError(code: -1, message: 'Unsupported HTTP method: $method');
      }

      print(response.body);

      if (success == response.statusCode) {
        return ApiResponse(code: response.statusCode, response: response.body);
      }

      throw ApiError(
          code: response.statusCode, message: json.decode(response.body).error);
    } on SocketException {
      throw ApiError(code: -1, message: 'No Internet Connection');
    } on FormatException {
      throw ApiError(code: -1, message: 'Invalid Format');
    } catch (e) {
      print(e);
      throw ApiError(code: -1, message: customErrorMessage);
    }
  }
}
