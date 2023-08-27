import 'dart:math';

import 'package:flutter/cupertino.dart';

class EventoTheme {
  final String? _emoji;

  final Color? _color1;
  final Color? _color2;

  // Initializer
  EventoTheme({String? emoji, Color? color1, Color? color2})
      : _emoji = emoji,
        _color1 = color1,
        _color2 = color2;

  factory EventoTheme.fromHex({String? emoji, String? hex1, String? hex2}) =>
      EventoTheme(
        emoji: emoji,
        color1: hex1 != null ? Color(int.parse(hex1, radix: 16)) : null,
        color2:
            hex1 != null ? Color(int.parse(hex2 ?? "002566", radix: 16)) : null,
      );

  factory EventoTheme.random() => EventoTheme(
        emoji: EventoTheme
            .emojiPool[Random().nextInt(EventoTheme.emojiPool.length)],
        color1: CupertinoColors.systemBlue,
        color2: CupertinoColors.systemBlue,
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

  // Getters
  String get emoji => _emoji ?? "🎉";
  Color get color1 => _color1 ?? CupertinoColors.systemBlue;
  Color get color2 => _color2 ?? CupertinoColors.systemBlue;
}
