import 'package:flutter/cupertino.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: CupertinoColors.white,
          ),
          SizedBox(width: 4.0),
          Text(title,
              style: TextStyle(
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  fontSize: 16)),
        ],
      ),
    );
  }
}
