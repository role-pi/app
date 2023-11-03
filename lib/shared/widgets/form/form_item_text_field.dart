import 'package:flutter/cupertino.dart';

class FormItemTextField extends StatelessWidget {
  const FormItemTextField(
      {this.controller,
      required this.title,
      this.padding = const EdgeInsets.all(8.0),
      this.textSize = 18,
      this.backgroundColor = CupertinoColors.secondarySystemBackground,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.enabled = true});

  final TextEditingController? controller;
  final String title;
  final EdgeInsets padding;
  final double textSize;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;

  TextStyle get style => TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.0,
      );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Container(
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
          keyboardType: keyboardType,
          style: style,
          validator: validator,
          readOnly: !enabled,
        ),
      ),
    );
  }
}
