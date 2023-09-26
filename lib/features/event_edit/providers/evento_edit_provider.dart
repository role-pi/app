import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/evento_edit_repository.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventoEditProvider extends ChangeNotifier {
  bool _loading = false;
  late Evento evento;

  EventoEditRepository eventoRepository = EventoEditRepository();

  late TextEditingController nameController;
  late bool changed = false;

  bool get loading => _loading;

  late FToast fToast;

  EventoEditProvider(int id) {
    evento = EventoListProvider.shared.evento(id);
    nameController = TextEditingController(text: evento.name);
    nameController.addListener(_textChanged);
    fToast = FToast();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
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
  }

  _textChanged() {
    evento.name = nameController.text;
    changed = true;
    notifyListeners();
  }

  setDataInicio(DateTime d) {
    evento.dataInicio = d;
    changed = true;
    notifyListeners();
  }

  setDataFim(DateTime d) {
    evento.dataFim = d;
    changed = true;
    notifyListeners();
  }
}
