import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ModalPopup {
  final BuildContext context;
  final String title;
  final Widget child;
  final EdgeInsets padding;

  const ModalPopup(
      {required this.context,
      required this.title,
      required this.child,
      this.padding = const EdgeInsets.only(top: 72)});

  void show() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          ModalPopupWidget(padding: padding, child: child, title: title),
    );
  }
}

class ModalPopupWidget extends StatefulWidget {
  const ModalPopupWidget({
    super.key,
    required this.padding,
    required this.child,
    required this.title,
  });

  final EdgeInsets padding;
  final Widget child;
  final String title;

  @override
  State<ModalPopupWidget> createState() => _ModalPopupWidgetState();
}

class _ModalPopupWidgetState extends State<ModalPopupWidget> {
  bool blur = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          blur = false;
        });
        return Future.value(true);
      },
      child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: blur ? 0 : 1, end: blur ? 1 : 0),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutQuad,
          builder: (_, value, __) {
            return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 16 * value,
                  sigmaY: 16 * value,
                ),
                child: Container(
                    padding: const EdgeInsets.only(top: 6.0),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Padding(
                            padding: widget.padding,
                            child: widget.child,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.2,
                                color:
                                    CupertinoColors.label.resolveFrom(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )));
          }),
    );
  }
}
