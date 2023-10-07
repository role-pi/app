import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class ContainerText extends StatelessWidget {
  const ContainerText(
      {super.key,
      required this.text,
      this.size = 19,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0)});

  final String text;
  final double size;
  final EdgeInsets padding;

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
      padding: padding,
      child: AutoSizeText(
        text,
        style: TextStyle(
            fontSize: size,
            letterSpacing: -1.4 / 19 * size,
            color: CupertinoDynamicColor.resolve(CupertinoColors.white, context)
                .withAlpha(200),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
