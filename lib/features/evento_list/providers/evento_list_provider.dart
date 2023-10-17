import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/models/evento.dart';
import 'package:role/features/evento_list/repository/evento_list_repository.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventoListProvider extends ChangeNotifier {
  bool _loading = false;
  List<Evento> _eventos = [];

  bool get loading => _loading;
  List<Evento> get eventos => _eventos;

  EventoListRepository eventoRepository = EventoListRepository();

  static final EventoListProvider shared = EventoListProvider();

  late FToast fToast;

  EventoListProvider() {
    get();
    fToast = FToast();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  set(List<Evento> eventosListModel) {
    _eventos = eventosListModel;
    notifyListeners();
  }

  get() async {
    set(await eventoRepository.getEventos());
  }

  delete(Evento evento, BuildContext context) async {
    bool result = await eventoRepository.deleteEvento(evento);

    fToast.init(context);
    Widget toast;
    if (result) {
      toast = CustomToast(
          title: "evento excluído",
          icon: CupertinoIcons.checkmark,
          color: evento.color1);

      _eventos.remove(evento);
      notifyListeners();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      toast = CustomToast(
          title: "erro ao excluir evento",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  Evento evento(int) {
    var evento = _eventos.firstWhere((element) => element.id == int);
    return evento;
  }
}
