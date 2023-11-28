import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/location.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventEditProvider extends ChangeNotifier {
  late EventDetailProvider eventDetailProvider;
  Event get event => eventDetailProvider.event;

  EventListProvider get eventListProvider => EventListProvider.shared;
  EventEditRepository eventRepository = EventEditRepository();

  late String _name;
  late DateTime? _startDate;
  late DateTime? _endDate;

  late TextEditingController nameController;
  late bool changed = false;

  late FToast fToast;

  EventEditProvider(EventDetailProvider eventDetailProvider) {
    this.eventDetailProvider = eventDetailProvider;

    _name = event.name;
    _startDate = event.startDate;
    _endDate = event.endDate;

    nameController = TextEditingController(text: event.name);
    nameController.addListener(_textChanged);
    fToast = FToast();
  }

  get() async {
    await eventDetailProvider.get();
    notifyListeners();
  }

  put(BuildContext context) async {
    changed = false;

    event.name = name;
    event.startDate = startDate;
    event.endDate = endDate;

    int? result = await eventRepository.putEvent(event);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "evento salvo",
          icon: CupertinoIcons.checkmark,
          color: event.color1);
    } else {
      toast = CustomToast(
          title: "erro ao salvar evento",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

    notifyListeners();

    eventDetailProvider.get();
  }

  String get name => _name;
  set name(String value) {
    _name = value;
    checkChanged();
    notifyListeners();
  }

  DateTime? get startDate => _startDate;
  set startDate(DateTime? value) {
    _startDate = value;
    checkChanged();
    notifyListeners();
  }

  DateTime? get endDate => _endDate;
  set endDate(DateTime? value) {
    _endDate = value;
    checkChanged();
    notifyListeners();
  }

  delete(BuildContext context) async {
    if (await eventListProvider.showDeletionDialog(context)) {
      await eventListProvider.delete(event, context);
    }
  }

  _textChanged() {
    name = nameController.text;
  }

  checkChanged() {
    if (event.name != name ||
        event.startDate != startDate ||
        event.endDate != endDate) {
      changed = true;
    } else {
      changed = false;
    }
    notifyListeners();
  }

  updateLocation(Location location) {
    event.location = location;
    notifyListeners();
    eventDetailProvider.notifyListeners();
  }

  Future<bool> showDeletionDialog(BuildContext context) async {
    final completer = Completer<bool>();

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("tem certeza?"),
        content: const Text("essa ação não poderá ser desfeita"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text("cancelar"),
            onPressed: () {
              Navigator.pop(context);
              completer.complete(false);
            },
          ),
          CupertinoDialogAction(
              child: const Text("remover participante"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                completer.complete(true);
              })
        ],
      ),
    );

    return completer.future;
  }

  removeUser(BuildContext context, User user) async {
    (int, int)? result = await eventRepository.putUsers(event, [], [user]);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "usuário removido",
          icon: CupertinoIcons.checkmark,
          color: event.color1);

      await get();
      notifyListeners();
    } else {
      toast = CustomToast(
          title: "erro ao atualizar usuários",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
