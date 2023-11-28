import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pix_flutter/pix_flutter.dart';
import 'package:role/features/split_costs/screens/qr_code_modal.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class SplitCostsProvider extends ChangeNotifier {
  late List<SplitCostTransaction> transactions;
  late FToast fToast;

  SplitCostsProvider(List<SplitCostTransaction> transactions) {
    this.transactions = transactions;
    fToast = FToast();
  }

  void showPixScreen(
      BuildContext context, SplitCostTransaction transaction) async {
    if (transaction.toUser.pixKey != null) {
      QRCodeModalPopup(transaction).show(context);
    }
  }

  void copyKey(BuildContext context, String key) {
    Clipboard.setData(ClipboardData(text: key));

    final toast = CustomToast(
      title: "chave copiada",
      icon: CupertinoIcons.check_mark,
      color: CupertinoColors.systemGreen,
    );

    fToast.init(context);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
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
