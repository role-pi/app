import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailExtras extends StatelessWidget {
  const UserDetailExtras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundButton(
          onPressed: () => showPopup(context),
          rectangleColor: CupertinoColors.systemRed,
          textColor: CupertinoColors.white,
          text: 'excluir conta',
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 12),
        RoundButton(
          onPressed: () async {
            UserLoginProvider.shared.logout();
            Navigator.pushNamed(context, "/onboarding");
          },
          rectangleColor: CupertinoColors.systemGrey5,
          textColor: CupertinoColors.systemRed,
          text: 'log out',
        ),
        SizedBox(height: 16),
        Text(
          "desenvolvido no ifsc gaspar",
          style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              letterSpacing: -1.0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        Text(
          "2023 © rolê",
          style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              letterSpacing: -1.0,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  void showPopup(BuildContext context) {
    TextStyle style = TextStyle(
      letterSpacing: -0.9,
      color: CupertinoColors.label.resolveFrom(context),
      fontWeight: FontWeight.bold,
    );

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("tem certeza?"),
        content: const Text("a exclusão de conta é uma ação irreversível"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text("voltar"),
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: style,
          ),
          CupertinoDialogAction(
            child: const Text("excluir conta"),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: style.copyWith(color: CupertinoColors.destructiveRed),
          )
        ],
      ),
    );
  }
}
