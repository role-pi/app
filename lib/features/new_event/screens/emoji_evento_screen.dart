import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewEmojiScreen extends StatefulWidget {
  final bool showing;
  final Function()? dismiss;

  NewEmojiScreen({required this.showing, this.dismiss});

  @override
  _NewEmojiScreenState createState() => _NewEmojiScreenState();
}

class _NewEmojiScreenState extends State<NewEmojiScreen> {
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  get value => null;

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "escolha um emoji",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
              color: CupertinoColors.black.withOpacity(0.8),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60,
              height: 60,
              color: CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              child: Text(
                "🎉",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              color: CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              child: Text(
                "🎊",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              color: CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              child: Text(
                "🎁",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Container(
              width: 100,
              height: 100,
              color: CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              child: Text(
                "🎄",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Container(
              width: 80,
              height: 80,
              color: CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              child: Text(
                "✨",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RoundButton(
            text: "criar evento",
            rectangleColor: CupertinoColors.black.withOpacity(0.8),
            onPressed: () {
              // Ação do botão
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
