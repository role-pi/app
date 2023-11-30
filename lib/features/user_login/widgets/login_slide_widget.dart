import 'package:flutter/cupertino.dart';

class LoginSlideWidget extends StatelessWidget {
  const LoginSlideWidget({
    super.key,
    required this.child,
    required this.showing,
    this.reversed = false,
  });

  final Widget child;
  final bool showing;
  final bool reversed;

  Duration get duration => Duration(milliseconds: 750);
  Curve get curve => Curves.easeInOutExpo;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !showing,
      child: AnimatedSlide(
        offset: showing ? Offset.zero : Offset(0, reversed ? 0.1 : -0.1),
        duration: duration,
        curve: curve,
        child: AnimatedOpacity(
            opacity: showing ? 1 : 0,
            duration: duration,
            curve: showing ? curve : Curves.easeOutCirc,
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        CupertinoColors.black.withOpacity(0),
                        CupertinoColors.black.withOpacity(0.9),
                        CupertinoColors.black.withOpacity(0.9),
                        CupertinoColors.black.withOpacity(0)
                      ],
                      stops: [0, 0.1, 0.9, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    padding: EdgeInsets.symmetric(horizontal: 42, vertical: 64),
                    child: child))),
      ),
    );
  }
}
