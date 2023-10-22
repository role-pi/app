import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/repository/evento_list_repository.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/event_theme.dart';

class NewEventoProvider extends ChangeNotifier {
  bool _loading = false;
  bool _showing = false;

  Event evento = Event(id: 0, name: "");

  EventoListRepository eventoRepository = EventoListRepository();

  static final NewEventoProvider shared = NewEventoProvider();

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  bool get showing => _showing;
  set showing(bool showing) {
    _showing = showing;
    if (showing) {
      evento = Event(id: 0, name: "");
    } else {
      EventoListProvider.shared.get();
      FocusManager.instance.primaryFocus?.unfocus();
    }
    notifyListeners();
  }

  setName(String name) {
    evento.name = name;
    notifyListeners();
  }

  setTheme(EventTheme theme) {
    evento.theme = theme;
    notifyListeners();
  }

  create() async {
    loading = true;
    var response = await eventoRepository.addEvento(evento);

    if (response != null) {
      showing = false;
    }
    loading = false;
  }
}
