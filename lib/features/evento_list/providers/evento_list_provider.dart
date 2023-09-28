import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';
import 'package:role/features/evento_list/repository/evento_list_repository.dart';

class EventoListProvider extends ChangeNotifier {
  bool _loading = false;
  List<Evento> _eventos = [];

  bool get loading => _loading;
  List<Evento> get eventos => _eventos;

  EventoListRepository eventoRepository = EventoListRepository();

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

  get() async {
    set(await eventoRepository.getEventos());
  }

  delete(Evento evento) async {
    // await eventoRepository.deleteEvento(evento);
    _eventos.remove(evento);
    notifyListeners();
  }

  Evento evento(int) {
    var evento = _eventos.firstWhere((element) => element.id == int);
    return evento;
  }
}
