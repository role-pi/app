import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class AddGuestsProvider extends ChangeNotifier {
  late EventEditProvider eventEditProvider;
  Event get event => eventEditProvider.event;

  EventEditRepository eventRepository = EventEditRepository();

  late TextEditingController searchController;
  late bool changed = false;

  List<UserSearchResult> users = [];

  List<User> addUsers = [];
  List<User> removeUsers = [];

  late FToast fToast;

  AddGuestsProvider(EventEditProvider eventEditProvider) {
    this.eventEditProvider = eventEditProvider;

    searchController = TextEditingController();
    searchController.addListener(_textChanged);
    fToast = FToast();
    get();
  }

  get() async {
    users = await eventRepository.searchUsers(event, searchController.text);
    notifyListeners();
  }

  put(BuildContext context) async {
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
  }

  _textChanged() async {
    get();
  }
}

class UserSearchResult {
  late User user;
  late bool selected;

  UserSearchResult({required this.user, required this.selected});

  @override
  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      UserSearchResult(
        user: User.fromJson(json),
        selected: json["participante"] == 1,
      );
}
