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

  late TextEditingController nameController,
      descricaoController,
      valueController;
  late bool changed = false;
  late bool loading = false;

  late FToast fToast;

  NewItemProvider(EventDetailProvider eventDetailProvider) {
    this.eventDetailProvider = eventDetailProvider;
    nameController = TextEditingController();
    descricaoController = TextEditingController();
    valueController = TextEditingController();

    nameController.addListener(_textChanged);
    descricaoController.addListener(_textChanged);
    valueController.addListener(_textChanged);

    fToast = FToast();
  }

  addItem(BuildContext context) async {
    changed = false;

    Item item = Item(
        id: 0,
        tipo: 1,
        nome: nameController.text,
        descricao: descricaoController.text,
        valor: double.parse(valueController.text),
        eventId: event.id);

    int? result = await newItemRepository.postItem(item);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "insumo adicionado com id $result",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
    } else {
      toast = CustomToast(
          title: "erro ao adicionar insumo",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    notifyListeners();

    eventDetailProvider.get();
  }

  setLoading(loading) {
    this.loading = loading;
    notifyListeners();
  }

  _textChanged() {
    changed = !nameController.text.isEmpty && !valueController.text.isEmpty;
    notifyListeners();
  }
}
