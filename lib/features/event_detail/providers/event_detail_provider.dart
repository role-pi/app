import 'package:flutter/cupertino.dart';
import 'package:role/features/event_detail/repository/event_detail_repository.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/user.dart';

class EventDetailProvider extends ChangeNotifier {
  late int id;
  late EventListProvider eventoListProvider;

  Event get evento => eventoListProvider.evento(id);

  EventDetailRepository eventoRepository = EventDetailRepository();

  EventDetailProvider(EventListProvider eventoListProvider, int id) {
    this.eventoListProvider = eventoListProvider;
    this.id = id;
    get();
  }

  updateEvento(Event? evento) {
    if (evento == null) return;
    this.evento.name = evento.name;
    this.evento.startDate = evento.startDate;
    this.evento.endDate = evento.endDate;
    this.evento.valorTotal = evento.valorTotal;
    this.evento.theme = evento.theme;
    notifyListeners();

    EventListProvider.shared.notifyListeners();
  }

  setItems(List<Item> items) {
    evento.items = items;
  }

  setUsuarios(List<User> usuarios) {
    evento.usuarios = usuarios;
  }

  get() async {
    updateEvento(await eventoRepository.getEvento(evento));
    setItems(await eventoRepository.getItems(evento));
    setUsuarios(await eventoRepository.getUsuarios(evento));

    notifyListeners();
  }
}
