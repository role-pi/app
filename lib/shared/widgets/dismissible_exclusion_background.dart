import 'package:flutter/cupertino.dart';

class DismissibleExclusionBackground extends StatelessWidget {
  final double size;

  const DismissibleExclusionBackground({super.key, this.size = 48});

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
