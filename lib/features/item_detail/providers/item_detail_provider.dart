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

  late TextEditingController nameController, descricaoController;

  late ItemCategory _tipo;
  late String _nome;
  late String _descricao;

  bool _changed = false;

  ItemDetailRepository itemRepository = ItemDetailRepository();

  FToast fToast = FToast();

  ItemDetailProvider(int id, int eventId) {
    this.id = id;
    this.eventDetailProvider = EventDetailProvider(eventId);

    _tipo = item.category;
    _nome = item.name;
    _descricao = item.notes;

    nameController = TextEditingController(text: nome);
    nameController.addListener(textChanged);
    descricaoController = TextEditingController(text: descricao);
    descricaoController.addListener(textChanged);

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

  ItemCategory get tipo => _tipo;
  set tipo(ItemCategory value) {
    _tipo = value;
    checkChanged();
    notifyListeners();
  }

  String get nome => _nome;
  set nome(String value) {
    _nome = value;
    checkChanged();
    notifyListeners();
  }

  String get descricao => _descricao;
  set descricao(String value) {
    _descricao = value;
    checkChanged();
    notifyListeners();
  }

  List<Transaction> get transactions => item.transactions;
  set transacoes(List<Transaction> value) {
    item.transactions = value;
    notifyListeners();
  }

  bool get changed => _changed;
  set changed(bool value) {
    _changed = value;
    notifyListeners();
  }

  checkChanged() {
    if (item.name != nome || item.notes != descricao || item.category != tipo) {
      _changed = true;
    } else {
      _changed = false;
    }
  }

  textChanged() {
    nome = nameController.text;
    descricao = descricaoController.text;
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

    item.name = nome;
    item.notes = descricao;
    item.category = tipo;
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
    transacoes = await itemRepository.getTransactions(item);
  }
}
