import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_event_provider.dart';
import 'package:role/features/new_event/widgets/new_event_name.dart';
import 'package:role/features/new_event/widgets/new_event_theme.dart';
import 'package:role/shared/widgets/blur_overlay.dart';

class NewEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewEventProvider>(builder: (context, provider, child) {
      return BlurOverlay(
          showing: provider.showing,
          onDismiss: () {
            provider.showing = false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Stack(children: [
              AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: provider.event.name.isEmpty ? 1 : 0,
                  child: NewEventName()),
              IgnorePointer(
                ignoring: provider.event.name.isEmpty,
                child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: provider.event.name.isEmpty ? 0 : 1,
                    child: NewEventTheme()),
              ),
            ]),
          ));
    });
  }
}
