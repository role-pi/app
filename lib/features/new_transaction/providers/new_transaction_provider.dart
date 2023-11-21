import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/new_transaction/repository/new_transaction_repository.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewTransactionProvider extends ChangeNotifier {
  late ItemDetailProvider itemDetailProvider;
  Item get item => itemDetailProvider.item;
  Event get event => itemDetailProvider.event;

  NewTransactionRepository repository = NewTransactionRepository();

  late TextEditingController valueController;
  late bool _changed = false;
  late bool _loading = false;

  late Transaction transaction;

  late FToast fToast;

  NewTransactionProvider(ItemDetailProvider itemDetailProvider) {
    this.itemDetailProvider = itemDetailProvider;

    valueController = TextEditingController();
    valueController.addListener(_valueChanged);

    User? user = UserLoginProvider.shared.user;
    if (user != null) {
      transaction = Transaction(
          id: 0, valor: 0, user: user, data: DateTime.now(), itemId: item.id);
    }

    fToast = FToast();
  }

  addTransaction(BuildContext context) async {
    changed = false;
    loading = true;

    int? result = await repository.postTransaction(transaction);

    fToast.init(context);
    Widget toast;

    if (result != null) {
      toast = CustomToast(
          title: "transação adicionada com id $result",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
      Navigator.of(context).pop();
    } else {
      toast = CustomToast(
          title: "erro ao adicionar transação",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
      loading = false;
      changed = true;
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    notifyListeners();

    itemDetailProvider.get();
  }

  bool get loading => _loading;
  set loading(loading) {
    _loading = loading;
    notifyListeners();
  }

  bool get changed => _changed;
  set changed(changed) {
    _changed = changed;
    notifyListeners();
  }

  _valueChanged() {
    double? value = double.tryParse(valueController.text);
    transaction.valor = value;
    updateChanged();
    notifyListeners();
  }

  selectUser(User user) {
    transaction.user = user;
    notifyListeners();
  }

  updateChanged() {
    changed = transaction.valor != null;
  }
}
