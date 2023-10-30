import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';

class LimitedTextField extends StatefulWidget {
  final int maxLength;
  final String title;
  final BoxDecoration containerDecoration;
  final double containerHeight;

  LimitedTextField({
    required this.maxLength,
    required this.title,
    this.containerDecoration = const BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.all(
          Radius.circular(10.0)), // Adiciona bordas arredondadas
    ),
    this.containerHeight = 200.0,
  });

  @override
  _LimitedTextFieldState createState() => _LimitedTextFieldState();
}

class _LimitedTextFieldState extends State<LimitedTextField> {
  final TextEditingController _controller = TextEditingController();

  int remainingCharacters = 0;

  @override
  Widget build(BuildContext context) {
    remainingCharacters = _controller.text.length;

    return Column(
      children: [
        FormItemGroupTitle(
          title: widget.title,
          accessoryText: '$remainingCharacters/300',
        ),
        SizedBox(height: 8),
        CupertinoTextField(
          controller: _controller,
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
    _controller.dispose();
    super.dispose();
  }
}
