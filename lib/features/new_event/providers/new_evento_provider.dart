import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/repository/evento_repository.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/shared/utils/api_status.dart';

class NewEventoProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  EventoRepository eventoRepository = EventoRepository();

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
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
