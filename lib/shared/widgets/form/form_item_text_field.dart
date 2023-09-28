import 'package:flutter/cupertino.dart';

class FormItemTextField extends StatelessWidget {
  const FormItemTextField({required this.controller, required this.title});

  final TextEditingController controller;
  final String title;

  static TextStyle style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemGrey6, context),
          borderRadius: BorderRadius.circular(12.0)),
      child: CupertinoTextFormFieldRow(
        padding: const EdgeInsets.all(8.0),
        controller: controller,
        placeholder: title,
        placeholderStyle: style.copyWith(
          color: CupertinoColors.tertiaryLabel.resolveFrom(context),
        ),
        style: style,
      ),
    );
  }
}
