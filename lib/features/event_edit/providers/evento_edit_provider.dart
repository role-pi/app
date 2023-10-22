import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/evento_edit_repository.dart';
import 'package:role/features/evento_detail/providers/evento_detail_provider.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventoEditProvider extends ChangeNotifier {
  late EventoDetailProvider eventoDetailProvider;
  Event get evento => eventoDetailProvider.evento;

  EventoEditRepository eventoRepository = EventoEditRepository();

  late TextEditingController nameController;
  late bool changed = false;

  late FToast fToast;

  EventoEditProvider(EventoDetailProvider eventoDetailProvider) {
    this.eventoDetailProvider = eventoDetailProvider;
    nameController = TextEditingController(text: evento.name);
    nameController.addListener(_textChanged);
    fToast = FToast();
  }

  updateData(BuildContext context) async {
    changed = false;

    int? result = await eventoRepository.putEvento(evento);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "evento salvo",
          icon: CupertinoIcons.checkmark,
          color: evento.color1);
    } else {
      toast = CustomToast(
          title: "erro ao salvar evento",
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

  delete(BuildContext context) {
    EventoListProvider.shared.delete(evento, context);
  }

  _textChanged() {
    evento.name = nameController.text;
    changed = true;
    notifyListeners();
  }

  setDataInicio(DateTime? d) {
    if (d != null) {
      evento.dataInicio = d;
      changed = true;
      notifyListeners();
    }
  }

  setDataFim(DateTime? d) {
    if (d != null) {
      evento.dataFim = d;
      changed = true;
      notifyListeners();
    }
  }
}
