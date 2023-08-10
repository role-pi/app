import 'package:flutter/cupertino.dart';

class CircleButton extends StatefulWidget {
  final Function() onTap;

  CircleButton({required this.onTap});

  @override
  _CircleButtonState createState() => _CircleButtonState(onTap: onTap);
}

class _CircleButtonState extends State<CircleButton> {
  final Function() onTap;

  _CircleButtonState({required this.onTap});

  bool isPressed = false;
  double size = 75;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        width: size,
        height: size,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          backgroundBlendMode: BlendMode.luminosity,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Lighter to darker gray
              CupertinoColors.systemGrey6,
              CupertinoColors.systemGrey5
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.15),
              // spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
        transform: (isPressed
            ? (Matrix4.identity()
              ..translate(0.025 * size,
                  0.025 * size) // translate towards right and down
              ..scale(0.95,
                  0.95)) // scale with to 95% anchorred at topleft of the AnimatedContainer
            : Matrix4.identity()),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Image.asset(
              'assets/Star.png',
              opacity: const AlwaysStoppedAnimation(.75),
              colorBlendMode: BlendMode.luminosity,
            ),
          ),
        ),
      ),
    );
  }
}
