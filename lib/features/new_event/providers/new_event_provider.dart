import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/repository/event_list_repository.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/event_theme.dart';

class NewEventProvider extends ChangeNotifier {
  bool _loading = false;
  bool _showing = false;

  Event event = Event(id: 0, name: "");

  EventListRepository eventRepository = EventListRepository();

  static final NewEventProvider shared = NewEventProvider();

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

  setName(String name) {
    event.name = name;
    notifyListeners();
  }

  setTheme(EventTheme theme) {
    event.theme = theme;
    notifyListeners();
  }

  create(BuildContext context) async {
    loading = true;
    int? response = await eventRepository.addEvent(event);

    if (response != null) {
      showing = false;
    }

    if (showing) {
      event = Event(id: 0, name: "");
    } else {
      await EventListProvider.shared.get();

      if (response != null) {
        Navigator.pushNamed(
          context,
          "/event",
          arguments: response,
        );
      }
      FocusManager.instance.primaryFocus?.unfocus();
    }

    loading = false;
  }
}
