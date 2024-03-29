import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_edit/repository/event_edit_repository.dart';
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

  toggle(int index) {
    users[index].selected = !users[index].selected;

    if (users[index].selected) {
      removeUsers.remove(users[index].user);
      addUsers.add(users[index].user);
    } else {
      addUsers.remove(users[index].user);
      removeUsers.add(users[index].user);
    }

    changed = addUsers.isNotEmpty || removeUsers.isNotEmpty;
    notifyListeners();
  }

  put(BuildContext context) async {
    changed = false;

    (int, int)? result =
        await eventRepository.putUsers(event, addUsers, removeUsers);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "usuários atualizados",
          icon: CupertinoIcons.checkmark,
          color: event.color1);

      Navigator.of(context).pop();
      await eventEditProvider.get();
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
