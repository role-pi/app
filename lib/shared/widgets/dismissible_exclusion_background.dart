import 'package:flutter/cupertino.dart';

class DismissibleExclusionBackground extends StatelessWidget {
  final double size;
  final double cornerRadius;

  const DismissibleExclusionBackground({super.key, this.size = 48, this.cornerRadius = 16});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
            decoration: BoxDecoration(
                color: CupertinoColors.destructiveRed,
                borderRadius: BorderRadius.circular(cornerRadius))),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            CupertinoIcons.trash,
            color: CupertinoColors.white,
            size: size,
          ),
        ),
      ],
    );
  }
}
