import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class RoundButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color rectangleColor;
  final Alignment alignment;
  final Function? onPressed;
  final bool loading;

  RoundButton({
    required this.text,
    this.textColor = CupertinoColors.systemBackground,
    this.rectangleColor = CupertinoColors.label,
    this.alignment = Alignment.center,
    this.onPressed,
    this.loading = true,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return ElasticButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color:
                  CupertinoDynamicColor.resolve(widget.rectangleColor, context),
              backgroundBlendMode: widget.onPressed != null
                  ? BlendMode.srcIn
                  : BlendMode.luminosity),
          child: Align(
            alignment: widget.alignment,
            child: Text(
              widget.text,
              style: TextStyle(
                color: CupertinoDynamicColor.resolve(widget.textColor, context),
                fontSize: 23,
                letterSpacing: -1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: widget.onPressed);
  }
}
