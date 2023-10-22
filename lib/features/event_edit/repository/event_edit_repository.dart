import 'dart:convert';

import '../../../shared/utils/api.dart';
import '../../../shared/utils/api_status.dart';
import '../../../models/event.dart';

class EventEditRepository {
  Future<int?> putEvento(Event evento) async {
    try {
      var response = await API()
          .request(endpoint: "evento", method: "PUT", body: evento.toJson());

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
