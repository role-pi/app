import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class SelectUserModalPopup extends ModalPopup {
  SelectUserModalPopup(
      {required BuildContext context,
      required Function(User) onSelected,
      required User user,
      required List<User> users})
      : super(
            context: context,
            title: "selecionar usuário",
            padding: EdgeInsets.only(top: 32),
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: users.indexWhere((u) => u.id == user.id)),
                itemExtent: 60,
                onSelectedItemChanged: (int index) {
                  onSelected(users[index]);
                },
                children: List<Widget>.generate(users.length, (index) {
                  User user = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Spacer(),
                        RemoteProfilePicture(url: user.profilePhoto, size: 28),
                        SizedBox(width: 12),
                        AutoSizeText(user.displayName),
                        Spacer(),
                      ],
                    ),
                  );
                }),
              ),
            ));
}

class SelectUserPreviewButton extends StatelessWidget {
  final User user;

  const SelectUserPreviewButton({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 13),
      child: Row(
        children: [
          RemoteProfilePicture(url: user.profilePhoto, size: 58),
          SizedBox(width: 12),
          Text(
            user.displayName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
