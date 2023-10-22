import 'package:flutter/cupertino.dart';
import 'package:role/features/event_detail/repository/event_detail_repository.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/user.dart';

class EventDetailProvider extends ChangeNotifier {
  late int id;
  late EventListProvider eventListProvider;

  Event get event => eventListProvider.event(id);

  EventDetailRepository eventRepository = EventDetailRepository();

  EventDetailProvider(EventListProvider eventListProvider, int id) {
    this.eventListProvider = eventListProvider;
    this.id = id;
    get();
  }

  updateEvent(Event? event) {
    if (event == null) return;
    this.event.name = event.name;
    this.event.startDate = event.startDate;
    this.event.endDate = event.endDate;
    this.event.valorTotal = event.valorTotal;
    this.event.theme = event.theme;
    notifyListeners();

    EventListProvider.shared.notifyListeners();
  }

  setItems(List<Item> items) {
    event.items = items;
  }

  setUsuarios(List<User> usuarios) {
    event.usuarios = usuarios;
  }

  get() async {
    updateEvent(await eventRepository.getEvento(event));
    setItems(await eventRepository.getItems(event));
    setUsuarios(await eventRepository.getUsuarios(event));

    notifyListeners();
  }
}
