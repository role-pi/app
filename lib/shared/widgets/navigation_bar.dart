import 'package:flutter/cupertino.dart';

class NavigationBar extends StatelessWidget {
  final String leadingText;
  final IconData? trailingIcon;
  final Function() onPressedLeading, onPressedTrailing;
  final Color color;

  const NavigationBar(
      {super.key,
      required this.leadingText,
      required this.trailingIcon,
      required this.onPressedLeading,
      required this.onPressedTrailing,
      this.color = CupertinoColors.label});

  @override
  Widget build(BuildContext context) {
    Color color = CupertinoDynamicColor.resolve(this.color, context);

    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 82.0),
      child: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Row(children: [
              Icon(
                CupertinoIcons.chevron_back,
                color: color,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  leadingText,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: -1.8),
                ),
              ),
            ]),
            onPressed: onPressedLeading,
          ),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              trailingIcon,
              color: color,
              size: 38,
            ),
            onPressed: onPressedTrailing,
          ),
        ],
      ),
    );
  }
}
