import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/item_detail/providers/item_detail_provider.dart';
import 'package:role/features/new_item/repository/new_item_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewTransactionProvider extends ChangeNotifier {
  late ItemDetailProvider itemDetailProvider;
  Event get event => itemDetailProvider.event;

  NewItemRepository newItemRepository = NewItemRepository();

  late User user;
  late TextEditingController valueController;
  late bool _changed = false;
  late bool _loading = false;

  late Transaction transaction;

  late FToast fToast;

  NewTransactionProvider(ItemDetailProvider itemDetailProvider) {
    this.itemDetailProvider = itemDetailProvider;
    valueController = TextEditingController();


    fToast = FToast();
  }

  addItem(BuildContext context) async {
    changed = false;
    loading = true;

    int? result = 1;

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "insumo adicionado com id $result",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
      Navigator.of(context).pop();
    } else {
      toast = CustomToast(
          title: "erro ao adicionar insumo",
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
}
