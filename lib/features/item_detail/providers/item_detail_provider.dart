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

    _tipo = item.tipo;
    _nome = item.nome;
    _descricao = item.descricao;

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
    this.item.nome = value.nome;
    this.item.valor = value.valor;
    this.item.tipo = value.tipo;
    this.item.descricao = value.descricao;
    this.item.data = value.data;

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

  List<Transaction> get transactions => item.transacoes;
  set transacoes(List<Transaction> value) {
    item.transacoes = value;
    notifyListeners();
  }

  bool get changed => _changed;
  set changed(bool value) {
    _changed = value;
    notifyListeners();
  }

  checkChanged() {
    if (item.nome != nome || item.descricao != descricao || item.tipo != tipo) {
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

  delete(BuildContext context) {
    eventDetailProvider.deleteItem(item, context);
    Navigator.of(context).pop();
  }

  put(BuildContext context) async {
    _changed = false;

    item.nome = nome;
    item.descricao = descricao;
    item.tipo = tipo;
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
