import 'package:flutter/cupertino.dart';

class BigFormTextField extends StatelessWidget {
  const BigFormTextField(
      {super.key,
      this.color = CupertinoColors.black,
      required this.controller,
      this.validator,
      this.onChanged});

  final Color color;
  final TextEditingController controller;
  final Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color, width: 2),
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
