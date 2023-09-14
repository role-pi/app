import 'package:flutter/cupertino.dart';

class CustomNavigationBar extends StatelessWidget {
  final String? leadingText, trailingText;
  final IconData? leadingIcon, trailingIcon;
  final Function()? onPressedLeading, onPressedTrailing;
  final Color color;
  final Color? accentColor;

  const CustomNavigationBar(
      {super.key,
      this.leadingText = "voltar",
      this.leadingIcon = CupertinoIcons.chevron_back,
      this.trailingText,
      this.trailingIcon,
      this.onPressedLeading,
      this.onPressedTrailing,
      this.color = CupertinoColors.label,
      this.accentColor});

  @override
  Widget build(BuildContext context) {
    Color color = CupertinoDynamicColor.resolve(this.color, context);
    Color accentColor =
        CupertinoDynamicColor.resolve(this.accentColor ?? color, context);

    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 82.0),
      child: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Row(children: [
              Icon(
                leadingIcon,
                color: color,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  leadingText ?? "",
                  style: TextStyle(
                      fontSize: 28,
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
            child: Row(children: [
              Icon(
                trailingIcon,
                color: accentColor ?? color,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  trailingText ?? "",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: -1.8),
                ),
              ),
            ]),
            onPressed: onPressedTrailing,
          ),
        ],
      ),
    );
  }
}
