import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/repository/new_item_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewItemProvider extends ChangeNotifier {
  late EventDetailProvider eventoDetailProvider;
  Event get event => eventoDetailProvider.event;

  NewItemRepository newItemRepository = NewItemRepository();

  late TextEditingController nameController,
      descricaoController,
      valorController;
  late bool changed = false;

  late FToast fToast;

  NewItemProvider(EventDetailProvider eventoDetailProvider) {
    this.eventoDetailProvider = eventoDetailProvider;
    nameController = TextEditingController();
    descricaoController = TextEditingController();
    valorController = TextEditingController();

    nameController.addListener(_textChanged);
    descricaoController.addListener(_textChanged);
    valorController.addListener(_textChanged);

    fToast = FToast();
  }

  addItem(BuildContext context) async {
    changed = false;

    Item item = Item(
        id: 0,
        tipo: 1,
        nome: nameController.text,
        descricao: descricaoController.text,
        valor: double.parse(valorController.text),
        eventoId: event.id);

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

    eventoDetailProvider.get();
  }

  _textChanged() {
    changed = true;
    notifyListeners();
  }
}
