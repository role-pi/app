import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/utils/api_status.dart';

class EventoDetailProvider extends ChangeNotifier {
  bool _loading = false;
  late Evento evento;

  bool get loading => _loading;

  EventoDetailProvider(int id) {
    evento = EventoListProvider.shared.evento(id);
    // get();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  get() async {
    await Future.delayed(const Duration(seconds: 1));

    // var response = await eventoRepository.getEventos();
    // set(response);
  }

  delete(Evento evento, BuildContext context) async {
    // await EventoListProvider.shared.delete(evento, context);
  }
}
