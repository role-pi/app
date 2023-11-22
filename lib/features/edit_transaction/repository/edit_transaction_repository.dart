import 'dart:convert';

import 'package:role/models/transaction.dart';

import 'package:role/shared/utils/api.dart';
import 'package:role/shared/utils/api_status.dart';

class EditTransactionRepository {
  Future<int?> putTransaction(Transaction transaction) async {
    try {
      var response = await API().request(
          endpoint: "transaction", method: "PUT", body: transaction.toJson());

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
