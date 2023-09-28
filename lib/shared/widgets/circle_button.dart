import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class CircleButton extends StatefulWidget {
  final Function() onTap;

  CircleButton({required this.onTap});

  @override
  _CircleButtonState createState() => _CircleButtonState(onTap: onTap);
}

class _CircleButtonState extends State<CircleButton> {
  final Function() onTap;

  _CircleButtonState({required this.onTap});

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: ElasticButton(
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Image.asset(
                    'assets/Star.png',
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.label, context),
                    opacity: const AlwaysStoppedAnimation(.90),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.luminosity,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CupertinoDynamicColor.resolve(
                            CupertinoColors.systemGrey5, context)
                        .withOpacity(0.8),
                    CupertinoDynamicColor.resolve(
                            CupertinoColors.systemGrey6, context)
                        .withOpacity(0.3)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.15),
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
