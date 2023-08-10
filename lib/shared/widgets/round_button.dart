import 'package:flutter/cupertino.dart';

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
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 16),
      borderRadius: BorderRadius.circular(16),
      color: rectangleColor.withAlpha(150),
      child: Container(
        width: double.infinity, // Expand horizontally
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor.withAlpha(200),
              fontSize: 24,
              letterSpacing: -1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
