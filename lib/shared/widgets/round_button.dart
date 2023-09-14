import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color rectangleColor;
  final VoidCallback onPressed;

  RoundButton({
    required this.text,
    this.textColor = CupertinoColors.systemGrey5,
    this.rectangleColor = CupertinoColors.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: CupertinoDynamicColor.resolve(
                  rectangleColor, context)), // Expand horizontally
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: CupertinoDynamicColor.resolve(
                    textColor, context), //.withAlpha(200),
                fontSize: 24,
                letterSpacing: -1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: onPressed);
  }
}
