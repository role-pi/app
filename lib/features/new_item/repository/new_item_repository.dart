import 'dart:convert';

import 'package:role/models/item.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class NewItemRepository {
  Future<int?> postItem(Item item) async {
    try {
      var response = await API()
          .request(endpoint: "insumo", method: "POST", body: item.toJson());

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
