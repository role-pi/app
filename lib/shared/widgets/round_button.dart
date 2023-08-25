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
    this.rectangleColor = CupertinoColors.black,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: rectangleColor), // Expand horizontally
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor, //.withAlpha(200),
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
