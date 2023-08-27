import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/features/new_event/widgets/new_evento_name.dart';
import 'package:role/features/new_event/widgets/new_evento_theme.dart';

class NewEventoScreen extends StatefulWidget {
  @override
  _NewEventoScreenState createState() => _NewEventoScreenState();
}

class _NewEventoScreenState extends State<NewEventoScreen> {
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventoProvider>(builder: (context, value, child) {
      return IgnorePointer(
        ignoring: !value.showing,
        child: GestureDetector(
          onTap: () {
            value.setShowing(false);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: ClipRect(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: value.showing ? 0 : 1, end: value.showing ? 1 : 0),
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
                            child: OverlayAction(),
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

class OverlayAction extends StatelessWidget {
  const OverlayAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventoProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: value.evento.name.isEmpty ? 1 : 0,
                child: NewEventoName()),
            IgnorePointer(
              ignoring: value.evento.name.isEmpty,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: value.evento.name.isEmpty ? 0 : 1,
                  child: NewEventoTheme()),
            ),
          ],
        );
      },
    );
  }
}
