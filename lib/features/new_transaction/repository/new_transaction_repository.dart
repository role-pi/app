import 'dart:convert';

import 'package:role/models/transaction.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class NewTransactionRepository {
  Future<int?> postTransaction(Transaction transaction) async {
    try {
      var response = await API().request(
          endpoint: "transaction", method: "POST", body: transaction.toJson());

      Map decoded = json.decode(response.response);
      return decoded["insertId"];
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
