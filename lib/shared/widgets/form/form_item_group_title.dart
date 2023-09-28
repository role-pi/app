import 'package:flutter/cupertino.dart';

class FormItemGroupTitle extends StatelessWidget {
  const FormItemGroupTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.9,
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey2, context),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
