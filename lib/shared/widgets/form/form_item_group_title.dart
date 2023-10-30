import 'package:flutter/cupertino.dart';

class FormItemGroupTitle extends StatelessWidget {
  const FormItemGroupTitle({required this.title, this.accessoryText = ""});

  final String title;
  final String accessoryText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.9,
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey2, context),
            ),
          ),
          Spacer(),
          Text(
            accessoryText,
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
