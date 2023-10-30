import 'dart:convert';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class ItemDetailRepository {
  Future<Item?> getItem(Item item) async {
    try {
      var response =
          await API().request(endpoint: "insumo/${item.id}", method: "GET");

      return Item.fromJson(json.decode(response.response));
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return null;
  }

  Future<int?> putItem(Item item) async {
    try {
      var response = await API()
          .request(endpoint: "insumo", method: "PUT", body: item.toJson());
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

  Future<List<Transaction>> getTransactions(Item item) async {
    try {
      var response = await API()
          .request(endpoint: "insumo/${item.id}/transacoes", method: "GET");
      return transactionsFromJSON(response.response);
    } catch (e) {
      if (e is ApiError) {
        print('Error Code: ${e.code}, Message: ${e.message}');
      } else {
        print('Unknown error occurred: $e');
      }
    }

    return [];
  }

  Future<bool> deleteTransaction(Transaction transaction) async {
    try {
      var response = await API()
          .request(endpoint: "transacao/${transaction.id}", method: "DELETE");

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

  List<Transaction> transactionsFromJSON(String str) => List<Transaction>.from(
      json.decode(str).map((x) => Transaction.fromJson(x)));
}
