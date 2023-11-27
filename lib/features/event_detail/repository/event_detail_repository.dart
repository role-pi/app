import 'dart:convert';

import 'package:role/features/split_costs/providers/split_costs_provider.dart';
import 'package:role/models/item.dart';
import 'package:role/models/user.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';
import 'package:role/models/event.dart';

class EventDetailRepository {
  Future<Event?> getEvent(Event event) async {
    try {
      var response =
          await API().request(endpoint: "event/${event.id}", method: "GET");

      return Event.fromJson(json.decode(response.response));
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<List<Item>> getItems(Event event) async {
    try {
      var response = await API()
          .request(endpoint: "event/${event.id}/items", method: "GET");

      return itemsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<bool> deleteItem(Item item) async {
    try {
      var response =
          await API().request(endpoint: "item/${item.id}", method: "DELETE");

      print(json.decode(response.response));
      return json.decode(response.response)["affectedRows"] > 0;
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return false;
  }

  Future<List<User>> getUsers(Event event) async {
    try {
      var response =
          await API().request(endpoint: "user/${event.id}", method: "GET");

      return usersFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<List<SplitCostTransaction>> getSplitCosts(
      Event event, String itemIds, String userIds) async {
    try {
      var response = await API().request(
          endpoint:
              "event/${event.id}/split?item_ids=${itemIds}&user_ids=${userIds}",
          method: "GET");

      return splitCostsTransactionsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  List<SplitCostTransaction> splitCostsTransactionsFromJSON(String str) =>
      List<SplitCostTransaction>.from(
          json.decode(str).map((x) => SplitCostTransaction.fromJson(x)));

  List<Item> itemsFromJSON(String str) =>
      List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

  List<User> usersFromJSON(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
