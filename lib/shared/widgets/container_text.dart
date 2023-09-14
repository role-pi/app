import 'package:flutter/cupertino.dart';

class ContainerText extends StatelessWidget {
  const ContainerText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final color = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Color.fromRGBO(100, 100, 100, 1)
        : Color.fromRGBO(80, 80, 80, 1);

    return Container(
      decoration: BoxDecoration(
          color: color,
          backgroundBlendMode: BlendMode.luminosity,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 19,
            letterSpacing: -1.4,
            color: CupertinoDynamicColor.resolve(CupertinoColors.white, context)
                .withAlpha(200),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
