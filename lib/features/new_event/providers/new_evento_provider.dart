import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/domain/models/evento.dart';
import 'package:role/features/event_list/domain/repository/evento_repository.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/shared/utils/api_status.dart';

class NewEventoProvider extends ChangeNotifier {
  bool _loading = false;
  List<Evento> _eventos = [];

  EventoRepository eventoRepository = EventoRepository();

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  set(List<Evento> eventosListModel) {
    _eventos = eventosListModel;
  }

  setUserError(Failure userError) {
    // _userError = userError;
  }

  add(nome) async {
    setLoading(true);
    await eventoRepository.addEvento(nome);
    EventoListProvider.shared.get();
    setLoading(false);
  }
}
