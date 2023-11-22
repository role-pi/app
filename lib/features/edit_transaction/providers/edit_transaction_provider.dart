import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/edit_transaction/repository/edit_transaction_repository.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EditTransactionProvider extends ChangeNotifier {
  late ItemDetailProvider itemDetailProvider;
  Item get item => itemDetailProvider.item;
  Event get event => itemDetailProvider.event;

  EditTransactionRepository repository = EditTransactionRepository();

  late TextEditingController valueController;
  late bool _changed = false;
  late bool _loading = false;

  late Transaction transaction;

  late FToast fToast;

  EditTransactionProvider(
      ItemDetailProvider itemDetailProvider, Transaction transaction) {
    this.itemDetailProvider = itemDetailProvider;

    valueController =
        TextEditingController(text: transaction.amount.toString());
    valueController.addListener(_valueChanged);

    this.transaction = transaction;

    fToast = FToast();
  }

  updateTransaction(BuildContext context) async {
    changed = false;
    loading = true;

    int? result = await repository.putTransaction(transaction);

    fToast.init(context);
    Widget toast;

    if (result != null) {
      toast = CustomToast(
          title: "transação atualizada",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
      Navigator.of(context).pop();
    } else {
      toast = CustomToast(
          title: "erro ao atualizar transação",
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
    transaction.amount = value;
    updateChanged();
    notifyListeners();
  }

  dateChanged(DateTime? date) {
    if (date != null) {
      transaction.date = date;
      updateChanged();
      notifyListeners();
    }
  }

  selectUser(User user) {
    transaction.user = user;
    notifyListeners();
  }

  updateChanged() {
    changed = transaction.amount != null;
  }
}
