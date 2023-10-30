import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BlurOverlay extends StatelessWidget {
  final bool showing;
  final Widget child;
  final Function()? onDismiss;

  BlurOverlay({
    required this.showing,
    required this.child,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: !showing,
        child: GestureDetector(
            onTap: onDismiss,
            child: ClipRect(
                child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                        begin: showing ? 0 : 1, end: showing ? 1 : 0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOutQuad,
                    builder: (_, value, __) {
                      return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: value * 16,
                            sigmaY: value * 16,
                          ),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CupertinoDynamicColor.resolve(
                                        CupertinoColors.systemBackground,
                                        context)
                                    .withOpacity(value * 0.7),
                              ),
                            ),
                            Transform(
                                transform: Matrix4.translationValues(
                                    0, (1 - value) * 12, 0),
                                child: Opacity(opacity: value, child: child))
                          ]));
                    }))));
  }
}
