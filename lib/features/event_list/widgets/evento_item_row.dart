import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

class EventoItemRow extends StatefulWidget {
  EventoItemRow({required this.evento, this.onTap});

  final Evento evento;
  final Function()? onTap;
  @override
  State<EventoItemRow> createState() => EventoItemRowState();
}

class EventoItemRowState extends State<EventoItemRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/evento",
          arguments: widget.evento.id,
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: GradientWidget(
            color1: widget.evento.randomColor1,
            color2: widget.evento.randomColor2,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.evento.randomEmoji,
                              style: TextStyle(
                                  fontSize: 52, fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        ContainerText(text: "R\$ " + widget.evento.valorTotal.toString()),
                      ],
                    ),
                    Text(widget.evento.name,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                            color: CupertinoColors.white.withAlpha(200))),
                    Text(
                        widget.evento.name == "Demonstração do PI"
                            ? "Hoje"
                            : widget.evento.name == "Primeira entrega"
                                ? "em 14 dias"
                                : "em 101 dias",
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: -1.5,
                            color: CupertinoColors.white.withAlpha(150))),
                  ],
                )),
          )),
    );
  }
}
