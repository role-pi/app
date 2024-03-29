import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ElasticButton extends StatefulWidget {
  final Widget child;
  final Function? onPressed;

  ElasticButton({required this.child, required this.onPressed});

  @override
  _ElasticButtonState createState() => _ElasticButtonState();
}

class _ElasticButtonState extends State<ElasticButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        HapticFeedback.mediumImpact();
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
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: AnimatedScale(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutQuart,
          scale: isPressed && widget.onPressed != null ? 0.925 : 1.0,
          child: widget.child),
    );
  }

  Matrix4 scaleXYZTransform({
    double scaleX = 1.00,
    double scaleY = 1.00,
    double scaleZ = 1.00,
  }) {
    return Matrix4.diagonal3Values(scaleX, scaleY, scaleZ);
  }
}
