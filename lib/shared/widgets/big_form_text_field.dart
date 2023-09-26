import 'package:flutter/cupertino.dart';

class BigFormTextField extends StatelessWidget {
  const BigFormTextField(
      {super.key,
      this.color = CupertinoColors.black,
      required this.controller,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.textInputAction = TextInputAction.continueAction});

  final Color color;
  final TextEditingController controller;
  final Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemFill, width: 3),
        ),
      ),
      child: CupertinoTextFormFieldRow(
        placeholder: " ",
        controller: controller,
        padding: EdgeInsets.all(10),
        textAlign: TextAlign.center,
        cursorColor: color,
        style: TextStyle(
          color: color,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.3,
        ),
        // textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          } else {
            return null;
          }
        },
        onChanged: onChanged,
      ),
    );
  }
}
