import 'dart:convert';

import 'package:role/models/insumo.dart';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/evento.dart';

class NewInsumoRepository {
  Future<int?> postInsumo(Insumo insumo) async {
    try {
      var response = await API()
          .request(endpoint: "insumo", method: "POST", body: insumo.toJson());

      List decoded = json.decode(response.response);
      return decoded[0]["insertId"];
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
