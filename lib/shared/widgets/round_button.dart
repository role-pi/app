import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color textColor;
  final Color rectangleColor;
  final Alignment alignment;
  final Function? onPressed;
  final bool loading;

  RoundButton({
    required this.text,
    this.icon,
    this.textColor = CupertinoColors.systemBackground,
    this.rectangleColor = CupertinoColors.label,
    this.alignment = Alignment.center,
    this.onPressed,
    this.loading = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: CupertinoDynamicColor.resolve(rectangleColor, context),
              backgroundBlendMode:
                  onPressed != null ? BlendMode.srcIn : BlendMode.luminosity),
          child: Align(
            alignment: alignment,
            child: Row(
              children: [
                Spacer(),
                icon != null
                    ? Icon(icon,
                        size: 23,
                        color:
                            CupertinoDynamicColor.resolve(textColor, context))
                    : SizedBox(),
                SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: CupertinoDynamicColor.resolve(textColor, context),
                    fontSize: 23,
                    letterSpacing: -1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        onPressed: onPressed);
  }
}
