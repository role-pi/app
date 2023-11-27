import 'package:flutter/cupertino.dart';
import 'package:role/models/user.dart';

class SplitCostsProvider {
  late List<SplitCostTransaction> transactions;

  SplitCostsProvider(List<SplitCostTransaction> transactions) {
    this.transactions = transactions;
  }

  void showPixScreen(
      BuildContext context, SplitCostTransaction transaction) async {}
}

class SplitCostTransaction {
  User fromUser;
  User toUser;
  double amount;

  SplitCostTransaction({
    required this.fromUser,
    required this.toUser,
    required this.amount,
  });

  @override
  factory SplitCostTransaction.fromJson(Map<String, dynamic> json) =>
      SplitCostTransaction(
        fromUser: User.fromJson(json['from']),
        toUser: User.fromJson(json['to']),
        amount: json['amount'],
      );
}
