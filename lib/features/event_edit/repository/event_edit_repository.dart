import 'dart:convert';

import 'package:role/features/event_edit/providers/add_guests_provider.dart';
import 'package:role/models/user.dart';
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

  Future<List<UserSearchResult>> searchUsers(Event event, String query) async {
    try {
      var response = await API().request(
          endpoint: "user?q=" + query + "&eventId=" + event.id.toString(),
          method: "GET");

      return userSearchResultsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return List.empty();
  }

  List<UserSearchResult> userSearchResultsFromJSON(String str) =>
      List<UserSearchResult>.from(
          json.decode(str).map((x) => UserSearchResult.fromJson(x)));
}
