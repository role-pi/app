import 'dart:math';
import 'dart:ui';

import 'package:role/models/insumo.dart';

class Evento {
  Evento(
      {required this.id,
      required this.name,
      this.dataInicio,
      this.dataFim,
      this.valorTotal});
  // required this.idUsuarios,
  // required this.idInsumos});

  int id;
  String name;
  DateTime? dataInicio;
  DateTime? dataFim;
  double? valorTotal;

  Insumo insumo = Insumo();
  // List<int> idUsuarios;
  // List<int> idInsumos;

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        id: json["id_evento"],
        name: json["nome"],
        dataInicio: json["data_inicio"] != null
            ? DateTime.parse(json["data_inicio"])
            : null,
        dataFim:
            json["data_fim"] != null ? DateTime.parse(json["data_fim"]) : null,
        valorTotal: double.parse(json["valor_total"]),
        // idUsuarios: json["id_usuarios"],
        // idInsumos: json["id_insumos"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dataInicio": dataInicio?.toIso8601String(),
        "dataFim": dataFim?.toIso8601String(),
        "valorTotal": valorTotal,
        // "id_usuarios": idUsuarios,
        // "id_insumis": idInsumos
      };

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

  String randomEmoji = emojiPool[Random().nextInt(emojiPool.length)];
  Color randomColor1 = generateRandomColor();
  Color randomColor2 = generateRandomColor();
}

Color generateRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255, // Set the alpha value to 255 for full opacity
    random.nextInt(256), // Red value (0-255)
    random.nextInt(256), // Green value (0-255)
    random.nextInt(256), // Blue value (0-255)
  );
}
