import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventEditProvider extends ChangeNotifier {
  late EventDetailProvider eventoDetailProvider;
  Event get evento => eventoDetailProvider.evento;

  EventEditRepository eventoRepository = EventEditRepository();

  late TextEditingController nameController;
  late bool changed = false;

  late FToast fToast;

  EventEditProvider(EventDetailProvider eventoDetailProvider) {
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
    EventListProvider.shared.delete(evento, context);
  }

  _textChanged() {
    evento.name = nameController.text;
    changed = true;
    notifyListeners();
  }

  setDataInicio(DateTime? d) {
    if (d != null) {
      evento.startDate = d;
      changed = true;
      notifyListeners();
    }
  }

  setDataFim(DateTime? d) {
    if (d != null) {
      evento.endDate = d;
      changed = true;
      notifyListeners();
    }
  }
}
