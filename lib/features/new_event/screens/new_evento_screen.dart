import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';

class NewEventoScreen extends StatefulWidget {
  final bool showing;
  Function()? dismiss;

  NewEventoScreen({required this.showing, this.dismiss});

  @override
  _NewEventoScreenState createState() => _NewEventoScreenState();
}

class _NewEventoScreenState extends State<NewEventoScreen> {
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  final _newEventoProvider = NewEventoProvider();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.showing,
      child: GestureDetector(
        onTap: widget.dismiss,
        child: ClipRect(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
                begin: widget.showing ? 0 : 10, end: widget.showing ? 10 : 0),
            duration: duration,
            curve: curve,
            builder: (_, value, __) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: value,
                  sigmaY: value,
                ),
                child: AnimatedOpacity(
                  opacity: widget.showing ? 0.6 : 0.0,
                  duration: duration,
                  curve: curve,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBackground,
                    ),
                    child: Center(
                      child: content(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Column content() {
    return Column(
      children: [
        Spacer(),
        CupertinoTextField(
          controller: _nameController,
          placeholder: "Nome do evento",
          padding: EdgeInsets.all(10),
          style: TextStyle(color: CupertinoColors.black),
        ),
        CupertinoButton(
          onPressed: () async {
            _newEventoProvider.add(_nameController.text);
            widget.dismiss!();
          },
          child: const Text('criar evento'),
        ),
        Spacer(),
      ],
    );
  }
}
