import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class EventEditProvider extends ChangeNotifier {
  late EventDetailProvider eventDetailProvider;
  Event get event => eventDetailProvider.event;

  EventListProvider get eventListProvider => EventListProvider.shared;
  EventEditRepository eventRepository = EventEditRepository();

  late String _name;
  late DateTime _startDate;
  late DateTime _endDate;

  late TextEditingController nameController;
  late bool changed = false;

  late FToast fToast;

  EventEditProvider(EventDetailProvider eventDetailProvider) {
    this.eventDetailProvider = eventDetailProvider;
    nameController = TextEditingController(text: event.name);
    nameController.addListener(_textChanged);
    fToast = FToast();
  }

  updateData(BuildContext context) async {
    changed = false;

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

  delete(BuildContext context) async {
    if (await eventListProvider.showDeletionDialog(context)) {
      await eventListProvider.delete(event, context);
    }
  }

  _textChanged() {
    event.name = nameController.text;
    changed = true;
    notifyListeners();
  }

  setDataInicio(DateTime? d) {
    if (d != null) {
      event.startDate = d;
      changed = true;
      notifyListeners();
    }
  }

  setDataFim(DateTime? d) {
    if (d != null) {
      event.endDate = d;
      changed = true;
      notifyListeners();
    }
  }
}
