import 'package:flutter/cupertino.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class NewTransactionSelectUserModalPopup extends ModalPopup {
  NewTransactionSelectUserModalPopup({
    required BuildContext context,
    required Function(User) onSelected,
    required User category,
    required List<User> users
  }) : super(
            context: context,
            title: "selecionar usuário",
            padding: EdgeInsets.only(top: 32),
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: 0),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  onSelected(users[index]);
                },
                children:
                    List<Widget>.generate(users.length, (index) {
                  User user = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(user.displayName),
                  );
                }),
              ),
            ));
}
