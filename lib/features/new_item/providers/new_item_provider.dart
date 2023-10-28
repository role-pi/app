import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/repository/new_item_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewItemProvider extends ChangeNotifier {
  late EventDetailProvider eventDetailProvider;
  Event get event => eventDetailProvider.event;

  NewItemRepository newItemRepository = NewItemRepository();

  late TextEditingController nameController, valueController;
  late bool _changed = false;
  late bool _loading = false;

  late Item item;

  late FToast fToast;

  NewItemProvider(EventDetailProvider eventDetailProvider) {
    this.eventDetailProvider = eventDetailProvider;
    nameController = TextEditingController();
    valueController = TextEditingController();

    nameController.addListener(_nameChanged);
    valueController.addListener(_valueChanged);

    item = Item(
        id: 0,
        valor: null,
        tipo: ItemCategory.other,
        nome: " ",
        descricao: "Descrição de teste",
        data: DateTime.now(),
        eventId: event.id);

    fToast = FToast();
  }

  addItem(BuildContext context) async {
    changed = false;
    loading = true;

    int? result = await newItemRepository.postItem(item);

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

    eventDetailProvider.get();
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

  set category(ItemCategory category) {
    item.tipo = category;
    notifyListeners();
  }

  _nameChanged() {
    item.nome = nameController.text;
    updateChanged();
  }

  _valueChanged() {
    double? value = double.tryParse(valueController.text);
    item.valor = value;
    updateChanged();
    notifyListeners();
  }

  updateChanged() {
    changed = !item.nome.isEmpty && item.valor != null;
  }
}
