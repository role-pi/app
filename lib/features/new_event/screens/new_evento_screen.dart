import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/features/new_event/widgets/new_evento_name.dart';
import 'package:role/features/new_event/widgets/new_evento_theme.dart';

class NewEventoScreen extends StatelessWidget {
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventoProvider>(builder: (context, provider, child) {
      return IgnorePointer(
        ignoring: !provider.showing,
        child: GestureDetector(
          onTap: () {
            provider.showing = false;
          },
          child: ClipRect(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: provider.showing ? 0 : 1,
                  end: provider.showing ? 1 : 0),
              duration: duration,
              curve: curve,
              builder: (_, value, __) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: value * 16,
                    sigmaY: value * 16,
                  ),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: value * 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemBackground,
                          ),
                        ),
                      ),
                      Transform(
                        transform:
                            Matrix4.translationValues(0, (1 - value) * 12, 0),
                        child: Opacity(
                          opacity: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Stack(children: [
                              AnimatedOpacity(
                                  duration: Duration(milliseconds: 200),
                                  opacity: provider.evento.name.isEmpty ? 1 : 0,
                                  child: NewEventoName()),
                              AnimatedOpacity(
                                  duration: Duration(milliseconds: 200),
                                  opacity: provider.evento.name.isEmpty ? 0 : 1,
                                  child: NewEventoTheme()),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
