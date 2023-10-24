import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ModalPopup {
  final BuildContext context;
  final String title;
  final double height;
  final Widget child;

  const ModalPopup(
      {required this.context,
      required this.title,
      required this.height,
      required this.child});

  void show() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
            height: height,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
              color: CupertinoColors.systemBackground.resolveFrom(context),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.2,
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                  ),
                  Spacer(),
                  child,
                  Spacer()
                ],
              ),
            )),
      ),
    );
  }
}
