import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';

class LimitedTextField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final String title;

  LimitedTextField({
    required this.controller,
    required this.maxLength,
    required this.title,
  });

  @override
  _LimitedTextFieldState createState() => _LimitedTextFieldState();
}

class _LimitedTextFieldState extends State<LimitedTextField> {
  int remainingCharacters = 0;

  @override
  Widget build(BuildContext context) {
    remainingCharacters = widget.controller.text.length;

    return Column(
      children: [
        FormItemGroupTitle(
          title: widget.title,
          accessoryText: '$remainingCharacters/300',
        ),
        SizedBox(height: 8),
        CupertinoTextField(
          controller: widget.controller,
          maxLines: null,
          maxLength: widget.maxLength,
          minLines: 5,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
              borderRadius: BorderRadius.circular(12.0 / 20.0 * 20)),
          onChanged: (text) {
            setState(() {
              remainingCharacters = widget.maxLength - text.length;
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
