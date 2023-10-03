import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color rectangleColor;
  final Alignment alignment;
  final VoidCallback onPressed;

  RoundButton({
    required this.text,
    this.textColor = CupertinoColors.white,
    this.rectangleColor = CupertinoColors.label,
    this.alignment = Alignment.center,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: CupertinoDynamicColor.resolve(rectangleColor, context)),
          child: Align(
            alignment: alignment,
            child: Text(
              text,
              style: TextStyle(
                color: CupertinoDynamicColor.resolve(textColor, context),
                fontSize: 23,
                letterSpacing: -1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: onPressed);
  }
}
