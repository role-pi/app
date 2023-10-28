import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailOptions extends StatelessWidget {
  const UserDetailOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundButton(
          onPressed: () {},
          rectangleColor: CupertinoColors.systemGrey5,
          textColor: CupertinoColors.label,
          text: 'relatório de uso',
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 12),
        RoundButton(
          onPressed: () => showPopup(context),
          rectangleColor: CupertinoColors.systemRed,
          textColor: CupertinoColors.white,
          text: 'excluir conta',
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  void showPopup(BuildContext context) {
    TextStyle style = TextStyle(
        letterSpacing: -0.9,
        color: CupertinoColors.label.resolveFrom(context),
        fontWeight: FontWeight.bold);

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
              textStyle: style),
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
