import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/models/event.dart';
import 'package:role/features/event_list/repository/event_list_repository.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventListProvider extends ChangeNotifier {
  bool _loading = false;
  List<Event> _events = [];

  bool get loading => _loading;
  List<Event> get events => _events;

  EventListRepository eventRepository = EventListRepository();

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

  set(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  get() async {
    set(await eventRepository.getEvents());
    print("GET");
  }

  delete(Event event, BuildContext context) async {
    bool result = await eventRepository.deleteEvent(event);

    fToast.init(context);
    Widget toast;
    if (result) {
      toast = CustomToast(
          title: "evento excluído",
          icon: CupertinoIcons.checkmark,
          color: event.color1);

      _events.remove(event);
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
    var event = _events.firstWhere((element) => element.id == id);
    return event;
  }
}
