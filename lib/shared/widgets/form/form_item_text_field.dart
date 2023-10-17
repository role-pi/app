import 'package:flutter/cupertino.dart';

class FormItemTextField extends StatelessWidget {
  const FormItemTextField(
      {required this.controller,
      required this.title,
      this.padding = const EdgeInsets.all(8.0),
      this.textSize = 20,
      this.backgroundColor = CupertinoColors.systemGrey5,
      this.validator});

  final TextEditingController controller;
  final String title;
  final EdgeInsets padding;
  final double textSize;
  final Color backgroundColor;
  final String? Function(String?)? validator;

  TextStyle get style => TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(backgroundColor, context),
          borderRadius: BorderRadius.circular(12.0 / 20.0 * textSize)),
      child: CupertinoTextFormFieldRow(
        padding: this.padding,
        controller: controller,
        placeholder: title,
        placeholderStyle: style.copyWith(
          color: CupertinoColors.tertiaryLabel.resolveFrom(context),
        ),
        style: style,
        validator: validator,
      ),
    );
  }
}
