import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/domain/models/evento.dart';
import 'package:role/features/event_list/domain/repository/evento_repository.dart';
import 'package:role/shared/utils/api_status.dart';

class EventoListProvider extends ChangeNotifier {
  bool _loading = false;
  List<Evento> _eventos = [];

  bool get loading => _loading;
  List<Evento> get eventos => _eventos;

  EventoRepository eventoRepository = EventoRepository();

  static final EventoListProvider shared = EventoListProvider();

  EventoListProvider() {
    get();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  set(List<Evento> eventosListModel) {
    _eventos = eventosListModel;
    notifyListeners();
  }

  setUserError(Failure userError) {
    // _userError = userError;
  }

  get() async {
    await Future.delayed(const Duration(seconds: 1));

    var response = await eventoRepository.getEventos();
    set(response);
  }
}
