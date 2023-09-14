import 'package:flutter/cupertino.dart';

class DefaultUserIcon extends StatelessWidget {
  const DefaultUserIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 58,
        height: 58,
        color:
            CupertinoDynamicColor.resolve(CupertinoColors.systemGrey6, context),
        child: const Icon(
          CupertinoIcons.person_fill,
          size: 28.0,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
