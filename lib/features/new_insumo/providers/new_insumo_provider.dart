import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/evento_edit_repository.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/features/new_insumo/repository/new_insumo_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewInsumoProvider extends ChangeNotifier {
  late EventoDetailProvider eventoDetailProvider;
  Event get evento => eventoDetailProvider.evento;

  NewInsumoRepository newInsumoRepository = NewInsumoRepository();

  late TextEditingController nameController,
      descricaoController,
      valorController;
  late bool changed = false;

  late FToast fToast;

  NewInsumoProvider(EventoDetailProvider eventoDetailProvider) {
    this.eventoDetailProvider = eventoDetailProvider;
    nameController = TextEditingController();
    descricaoController = TextEditingController();
    valorController = TextEditingController();

    nameController.addListener(_textChanged);
    descricaoController.addListener(_textChanged);
    valorController.addListener(_textChanged);

    fToast = FToast();
  }

  addInsumo(BuildContext context) async {
    changed = false;

    Item insumo = Item(
        id: 0,
        tipo: 1,
        nome: nameController.text,
        descricao: descricaoController.text,
        valor: double.parse(valorController.text),
        eventoId: evento.id);

    int? result = await newInsumoRepository.postInsumo(insumo);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "insumo adicionado com id $result",
          icon: CupertinoIcons.checkmark,
          color: evento.color1);
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
