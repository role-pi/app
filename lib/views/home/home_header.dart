import 'package:flutter/cupertino.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset('assets/Logo.png', height: 50),
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            "próximos eventos",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black.withAlpha((255 * 0.2).toInt()),
                letterSpacing: -1.5),
          ),
        ),
      ],
    );
  }
}
