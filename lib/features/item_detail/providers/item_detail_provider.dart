import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/features/item_detail/repository/item_detail_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/transaction.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class ItemDetailProvider extends ChangeNotifier {
  late int id;
  late EventDetailProvider eventDetailProvider;

  late TextEditingController nameController, notesController;

  late ItemCategory _category;
  late String _name;
  late String _notes;

  bool _changed = false;

  ItemDetailRepository itemRepository = ItemDetailRepository();

  FToast fToast = FToast();

  ItemDetailProvider(int id, int eventId) {
    this.id = id;
    this.eventDetailProvider = EventDetailProvider(eventId);

    _category = item.category;
    _name = item.name;
    _notes = item.notes;

    nameController = TextEditingController(text: name);
    nameController.addListener(textChanged);
    notesController = TextEditingController(text: notes);
    notesController.addListener(textChanged);

    get();
  }

  Event get event => eventDetailProvider.event;

  Item get item => eventDetailProvider.item(id);
  set item(Item? value) {
    if (value == null) return;
    this.item.name = value.name;
    this.item.amount = value.amount;
    this.item.category = value.category;
    this.item.notes = value.notes;
    this.item.date = value.date;

    notifyListeners();
    EventListProvider.shared.notifyListeners();
  }

  ItemCategory get category => _category;
  set category(ItemCategory value) {
    _category = value;
    checkChanged();
    notifyListeners();
  }

  String get name => _name;
  set name(String value) {
    _name = value;
    checkChanged();
    notifyListeners();
  }

  String get notes => _notes;
  set notes(String value) {
    _notes = value;
    checkChanged();
    notifyListeners();
  }

  List<Transaction> get transactions => item.transactions;
  set transactions(List<Transaction> value) {
    item.transactions = value;
    notifyListeners();
  }

  bool get changed => _changed;
  set changed(bool value) {
    _changed = value;
    notifyListeners();
  }

  checkChanged() {
    if (item.name != name || item.notes != notes || item.category != category) {
      _changed = true;
    } else {
      _changed = false;
    }
  }

  textChanged() {
    name = nameController.text;
    notes = notesController.text;
    checkChanged();
  }

  delete(BuildContext context) async {
    if (await eventDetailProvider.showDeletionDialog(context)) {
      eventDetailProvider.deleteItem(item, context);
      Navigator.of(context).pop();
    }
  }

  put(BuildContext context) async {
    _changed = false;

    item.name = name;
    item.notes = notes;
    item.category = category;
    int? result = await itemRepository.putItem(item);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "item salvo",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
    } else {
      toast = CustomToast(
          title: "erro ao salvar item",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    FocusScope.of(context).unfocus();
    notifyListeners();
    eventDetailProvider.get();
  }

  get() async {
    item = await itemRepository.getItem(item);
    transactions = await itemRepository.getTransactions(item);
    notifyListeners();
  }
}
