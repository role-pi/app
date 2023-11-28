import 'package:flutter/cupertino.dart';

class CustomNavigationBar extends StatelessWidget {
  final String? leadingText, trailingText, title;
  final IconData? leadingIcon, trailingIcon;
  final Function()? onPressedLeading, onPressedTrailing;
  final Color color;
  final Color? accentColor;
  final double topPadding;
  final double textSize;

  const CustomNavigationBar(
      {super.key,
      this.leadingText = "voltar",
      this.leadingIcon = CupertinoIcons.chevron_back,
      this.trailingText,
      this.trailingIcon,
      this.title,
      this.onPressedLeading,
      this.onPressedTrailing,
      this.color = CupertinoColors.label,
      this.accentColor,
      this.topPadding = 54.0,
      this.textSize = 28.0});

  @override
  Widget build(BuildContext context) {
    Color color = CupertinoDynamicColor.resolve(this.color, context);
    Color accentColor = onPressedTrailing == null
        ? color.withOpacity(0.2)
        : CupertinoDynamicColor.resolve(this.accentColor ?? color, context);

    return Padding(
      padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 28.0 + topPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Row(children: [
                  leadingIcon != null
                      ? Icon(
                          leadingIcon,
                          color: color,
                          size: textSize * 30 / 28,
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      leadingText ?? "",
                      style: TextStyle(
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: -textSize * 1.8 / 28),
                    ),
                  ),
                ]),
                onPressed: onPressedLeading,
              ),
              Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Row(children: [
                  trailingIcon != null
                      ? Icon(
                          trailingIcon,
                          color: accentColor,
                          size: textSize * 30 / 28,
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      trailingText ?? "",
                      style: TextStyle(
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                          letterSpacing: -textSize * 1.8 / 28),
                    ),
                  ),
                ]),
                onPressed: onPressedTrailing,
              ),
            ],
          ),
          SizedBox(height: 8),
          title != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title!,
                    style: TextStyle(
                        color: color,
                        fontSize: textSize * 1.3,
                        fontWeight: FontWeight.bold,
                        height: textSize * 1.1 / 28,
                        letterSpacing: -textSize * 1.8 / 28),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
