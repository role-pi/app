import 'dart:convert';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/models/event.dart';

class EventEditRepository {
  Future<int?> putEvent(Event event) async {
    try {
      var response = await API()
          .request(endpoint: "event", method: "PUT", body: event.toJson());

      Map decoded = json.decode(response.response);
      return decoded["affectedRows"];
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
