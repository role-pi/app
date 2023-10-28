import 'package:flutter/cupertino.dart';

class DismissibleExclusionBackground extends StatelessWidget {
  const DismissibleExclusionBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
            decoration: BoxDecoration(
                color: CupertinoColors.destructiveRed,
                borderRadius: BorderRadius.circular(16))),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            CupertinoIcons.trash,
            color: CupertinoColors.white,
            size: 48,
          ),
        ),
      ],
    );
  }
}
