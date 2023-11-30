import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_list/repository/event_list_repository.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/event_theme.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class NewEventProvider extends ChangeNotifier {
  bool _loading = false;
  bool _showing = false;

  Event event = Event(id: 0, name: "");

  EventListRepository eventRepository = EventListRepository();

  static final NewEventProvider shared = NewEventProvider();

  late final TextEditingController nameController;

  late final FToast fToast;

  NewEventProvider() {
    nameController = TextEditingController();
    fToast = FToast();
  }

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool get showing => _showing;
  set showing(bool showing) {
    event = Event(id: 0, name: "");
    _showing = showing;
    notifyListeners();
  }

  setName(BuildContext context) {
    event.name = nameController.text;
    nameController.text;
    nameController.clear();

    FocusScope.of(context).unfocus();

    notifyListeners();
  }

  setTheme(EventTheme theme) {
    event.theme = theme;
    notifyListeners();
  }

  create(BuildContext context) async {
    FocusScope.of(context).unfocus();

    loading = true;
    int? response = await eventRepository.postEvent(event);

    showing = false;
    event = Event(id: 0, name: "");

    await EventListProvider.shared.get();

    if (response != null) {
      Navigator.pushNamed(
        context,
        "/event",
        arguments: response,
      );
    } else {
      fToast.init(context);
      fToast.showToast(
        child: CustomToast(
            title: "erro ao criar evento",
            icon: CupertinoIcons.xmark,
            color: CupertinoColors.systemRed),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
      );
    }

    loading = false;
  }
}
