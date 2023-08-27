import 'package:flutter/cupertino.dart';

class ContainerText extends StatelessWidget {
  const ContainerText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoColors.black.withAlpha(90),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20,
            letterSpacing: -1.3,
            color: CupertinoColors.white.withAlpha(150),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
