import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/features/new_event/widgets/new_evento_name.dart';
import 'package:role/features/new_event/widgets/new_evento_theme.dart';

class NewEventoScreen extends StatelessWidget {
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
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutQuad,
              builder: (_, value, __) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: value * 16,
                    sigmaY: value * 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.systemBackground, context)
                              .withOpacity(value * 0.6),
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
                              IgnorePointer(
                                ignoring: provider.evento.name.isEmpty,
                                child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 200),
                                    opacity:
                                        provider.evento.name.isEmpty ? 0 : 1,
                                    child: NewEventoTheme()),
                              ),
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
