import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_detail/repository/event_detail_repository.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/item.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventDetailProvider extends ChangeNotifier {
  late int id;
  late EventListProvider eventListProvider;

  Event get event => eventListProvider.event(id);

  EventDetailRepository eventRepository = EventDetailRepository();

  FToast fToast = FToast();

  EventDetailProvider(int id) {
    this.eventListProvider = EventListProvider.shared;
    this.id = id;
    get();
  }

  updateEvent(Event? event) {
    if (event == null) return;
    this.event.name = event.name;
    this.event.startDate = event.startDate;
    this.event.endDate = event.endDate;
    this.event.totalAmount = event.totalAmount;
    this.event.theme = event.theme;
    notifyListeners();

    EventListProvider.shared.notifyListeners();
  }

  deleteItem(Item item, BuildContext context) async {
    bool result = await eventRepository.deleteItem(item);

    fToast.init(context);
    Widget toast;
    if (result) {
      toast = CustomToast(
          title: "insumo excluído",
          icon: CupertinoIcons.checkmark,
          color: event.color1);

      event.items?.remove(item);
      notifyListeners();
    } else {
      toast = CustomToast(
          title: "erro ao excluir insumo",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  setItems(List<Item> items) {
    event.items = items;
  }

  setUsers(List<User> users) {
    event.users = users;
  }

  get() async {
    updateEvent(await eventRepository.getEvent(event));
    setItems(await eventRepository.getItems(event));
    setUsers(await eventRepository.getUsers(event));

    notifyListeners();
  }

  item(id) {
    return event.items?.firstWhere((element) => element.id == id);
  }
}
