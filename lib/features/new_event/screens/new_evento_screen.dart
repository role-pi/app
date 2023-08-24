import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/shared/widgets/big_form_text_field.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEventoScreen extends StatefulWidget {
  final bool showing;
  final Function()? dismiss;

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
                begin: widget.showing ? 0 : 16, end: widget.showing ? 16 : 0),
            duration: duration,
            curve: curve,
            builder: (_, value, __) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: value,
                  sigmaY: value,
                ),
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: widget.showing ? 0.6 : 0.0,
                      duration: duration,
                      curve: curve,
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBackground,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: widget.showing ? 1.0 : 0.0,
                      duration: duration,
                      curve: curve,
                      child: Center(
                        child: content(),
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
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Spacer(),
          BigFormTextField(
            controller: _nameController,
            color: CupertinoColors.black,
            // onChanged: (value) {
            //   setState(() {
            //     showBack = value?.isEmpty ?? true;
            //   });
            // },
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundButton(
              text: "criar evento",
              onPressed: () async {
                _newEventoProvider.add(_nameController.text);
                widget.dismiss!();
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
