import 'package:flutter/cupertino.dart';

class LimitedTextField extends StatefulWidget {
  final int maxLength;
  final String hintText;
  final BoxDecoration containerDecoration;
  final double containerHeight;

  LimitedTextField({
    required this.maxLength,
    required this.hintText,
    this.containerDecoration = const BoxDecoration(
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.all(Radius.circular(10.0)), // Adiciona bordas arredondadas
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
    remainingCharacters = widget.maxLength - _controller.text.length;

    return Container(
      decoration: widget.containerDecoration,
      height: 90,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CupertinoTextField(
            controller: _controller,
            maxLines: null,
            maxLength: widget.maxLength,
            placeholder: widget.hintText,
            onChanged: (text) {
              setState(() {
                remainingCharacters = widget.maxLength - text.length;
              });
            },
          ),
          SizedBox(height: 8.0),
          Text(
            '$remainingCharacters /300',
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
