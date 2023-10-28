import 'package:flutter/cupertino.dart';

class EmtpyListIndicator extends StatelessWidget {
  final String text;

  const EmtpyListIndicator({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.5,
        child: Container(
            decoration: BoxDecoration(
                color: CupertinoDynamicColor.resolve(
                    CupertinoColors.systemGrey6, context),
                border: Border.all(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemGrey5, context),
                    width: 4),
                borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
              child: Text(
                text,
                style:
                    TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.8),
                textAlign: TextAlign.center,
              ),
            )));
  }
}
