import 'dart:async';

import 'package:flutter/cupertino.dart';

class WrappedButton extends StatefulWidget {
  @override
  _WrappedButtonState createState() => _WrappedButtonState();
}

class _WrappedButtonState extends State<WrappedButton> {
  double hue = 0.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        hue = (hue + 5) % 360.0;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HSLColor.fromAHSL(1.0, hue, 1.0, 0.05).toColor(),
            HSLColor.fromAHSL(1.0, hue, 1.0, 0.25).toColor(),
            HSLColor.fromAHSL(1.0, (hue + 20) % 360.0, 1.0, 0.5).toColor()
          ],
          stops: [0.5, 0.8, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Image.asset("assets/Invertida.png", height: 26),
          SizedBox(width: 8),
          Text("wrapped",
              style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.9))
        ],
      ),
    );
  }
}
