import 'package:flutter/cupertino.dart';

class DefaultUserIcon extends StatelessWidget {
  double size;

  DefaultUserIcon({super.key, this.size = 58});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color:
            CupertinoDynamicColor.resolve(CupertinoColors.systemGrey6, context),
        child: Icon(
          CupertinoIcons.person_fill,
          size: size * 0.5,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
