import 'dart:convert';
import 'dart:io';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:http/http.dart' as http;
import 'package:role/shared/utils/constants.dart';

class API {
  Future<ApiResponse> request({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    bool auth = true,
    dynamic body,
  }) async {
    try {
      http.Response response;

      headers = headers ?? {"Content-Type": "application/json"};
      body = json.encode(body);

      if (auth) {
        String token = await UserLoginProvider.shared.readToken();
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

      print(response.statusCode);

      if (success == response.statusCode) {
        return ApiResponse(code: response.statusCode, response: response.body);
      }

      throw ApiError(
          code: response.statusCode,
          message: json.decode(response.body)["error"]);
    } on SocketException {
      throw ApiError(code: -1, message: 'No Internet Connection');
    } on FormatException {
      throw ApiError(code: -1, message: 'Invalid Format');
    }
  }

  Future<ApiResponse> uploadFile({
    required File file,
    required String field,
    required String endpoint,
    bool auth = true,
  }) async {
    try {
      String url = '${api}${endpoint}';
      var request = http.MultipartRequest('POST', Uri.parse(url));

      if (auth) {
        String token = await UserLoginProvider.shared.readToken();
        request.headers.addAll({"Authorization": "JWT ${token}"});
      }

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(field, fileStream, length,
          filename: file.path.split('/').last);

      request.files.add(multipartFile);

      var response = await request.send();
      var value = await response.stream.bytesToString();

      if (success == response.statusCode) {
        return ApiResponse(code: response.statusCode, response: value);
      }

      throw ApiError(code: response.statusCode, message: "Unknown Error");
    } on SocketException {
      throw ApiError(code: -1, message: 'No Internet Connection');
    } on FormatException {
      throw ApiError(code: -1, message: 'Invalid Format');
    }
  }
}
