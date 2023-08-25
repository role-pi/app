import 'dart:ffi';
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
  bool enabled = false;

  final _formKey = GlobalKey<FormState>();
  final _newEventoProvider = NewEventoProvider();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.showing,
      child: GestureDetector(
        onTap: () {
          widget.dismiss!();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ClipRect(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
                begin: widget.showing ? 0 : 1, end: widget.showing ? 1 : 0),
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
                          child: _buildForm(),
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
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              Text(
                "novo evento",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                  color: CupertinoColors.black.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(height: 24.0),
          BigFormTextField(
            controller: _nameController,
            color: CupertinoColors.black.withOpacity(0.5),
            onChanged: (value) {
              // setState(() {
              //   enabled = !value?.isEmpty ?? false;
              // });
            },
            onFieldSubmitted: (_) {
              onSubmit();
            },
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundButton(
              text: "criar",
              rectangleColor: CupertinoColors.black.withOpacity(0.8),
              onPressed: onSubmit,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  void onSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await _newEventoProvider.add(_nameController.text);
    _nameController.clear();
    widget.dismiss!();
  }
}
