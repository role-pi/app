import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/models/event.dart';
import 'package:role/features/event_list/repository/evento_list_repository.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventListProvider extends ChangeNotifier {
  bool _loading = false;
  List<Event> _eventos = [];

  bool get loading => _loading;
  List<Event> get eventos => _eventos;

  EventListRepository eventoRepository = EventListRepository();

  static final EventListProvider shared = EventListProvider();

  late FToast fToast;

  EventListProvider() {
    get();
    fToast = FToast();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  set(List<Event> eventosListModel) {
    _eventos = eventosListModel;
    notifyListeners();
  }

  get() async {
    set(await eventoRepository.getEventos());
  }

  delete(Event evento, BuildContext context) async {
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

  Event event(id) {
    var event = _eventos.firstWhere((element) => element.id == id);
    return event;
  }
}
