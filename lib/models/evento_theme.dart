import 'dart:math';

import 'package:flutter/cupertino.dart';

class EventoTheme {
  final String? _emoji;

  final Color? _color1;
  final Color? _color2;

  EventoTheme({String? emoji, Color? color1, Color? color2})
      : _emoji = emoji,
        _color1 = color1,
        _color2 = color2;

  factory EventoTheme.fromHex({String? emoji, String? hex1, String? hex2}) =>
      EventoTheme(
          emoji: emoji,
          color1: hex1 == null ? null : HexColor.fromHex(hex1),
          color2: hex2 == null ? null : HexColor.fromHex(hex2));

  factory EventoTheme.random() => EventoTheme(
        emoji: EventoTheme
            .emojiPool[Random().nextInt(EventoTheme.emojiPool.length)],
        color1: RandomColor.generate(),
        color2: RandomColor.generate(),
      );

  static List<String> emojiPool = [
    '🎉',
    '🎊',
    '🎈',
    '🎁',
    '🎂',
    '🎄',
    '🎃',
    '🎆',
    '✨',
    '🪩'
  ];

  String get emoji => _emoji ?? "";
  Color get accentColor =>
      _color1 == null ? CupertinoColors.systemGrey : CupertinoColors.black;
  Color get color1 => _color1 ?? CupertinoColors.systemGrey6;
  Color get color2 => _color2 ?? CupertinoColors.systemGrey6;
}

extension HexColor on Color {
  String toHex({bool withAlpha = false}) {
    String hex = withAlpha
        ? value.toRadixString(16)
        : value.toRadixString(16).substring(2);
    return hex.toUpperCase();
  }

  static Color fromHex(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF" + hex;
    }
    return Color(int.parse(hex, radix: 16));
  }
}

extension RandomColor on Color {
  static Color generate() {
    Random random = Random();
    return Color.fromARGB(
      255, // Set the alpha value to 255 for full opacity
      random.nextInt(256), // Red value (0-255)
      random.nextInt(256), // Green value (0-255)
      random.nextInt(256), // Blue value (0-255)
    );
  }
}
