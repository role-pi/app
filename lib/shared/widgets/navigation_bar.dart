import 'package:flutter/cupertino.dart';

class NavigationBar extends StatelessWidget {
  final Widget leading, trailing;
  final Function() onPressedLeading, onPressedTrailing;

  const NavigationBar(
      {super.key,
      required this.leading,
      required this.trailing,
      required this.onPressedLeading,
      required this.onPressedTrailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 82.0),
      child: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: leading,
            onPressed: onPressedLeading,
          ),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: trailing,
            onPressed: onPressedTrailing,
          ),
        ],
      ),
    );
  }
}
