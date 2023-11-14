import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class AddGuestsProvider extends ChangeNotifier {
  late EventDetailProvider eventDetailProvider;
  Event get event => eventDetailProvider.event;

  EventListProvider get eventListProvider => EventListProvider.shared;
  EventEditRepository eventRepository = EventEditRepository();

  late TextEditingController searchController;
  late bool changed = false;

  late FToast fToast;

  EventEditProvider(EventDetailProvider eventDetailProvider) {
    this.eventDetailProvider = eventDetailProvider;

    searchController = TextEditingController(text: event.name);
    fToast = FToast();
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

  _textChanged() {}
}
