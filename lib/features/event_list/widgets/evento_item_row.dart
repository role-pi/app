import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

class EventoItemRow extends StatelessWidget {
  EventoItemRow({required this.evento, this.onTap});

  final Evento evento;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/evento",
          arguments: evento.id,
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: GradientWidget(
            color1: CupertinoDynamicColor.resolve(evento.color1, context),
            color2: CupertinoDynamicColor.resolve(evento.color2, context),
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
                        evento.emoji.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(evento.emoji,
                                    style: TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.bold)),
                              )
                            : SizedBox(height: 60),
                        Spacer(),
                        ContainerText(
                            text: "R\$ " + evento.valorTotal.toString()),
                      ],
                    ),
                    Text(evento.name,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                            color: CupertinoDynamicColor.resolve(
                                    evento.theme.accentColor, context)
                                .withAlpha(200))),
                    Text(
                        evento.name == "Demonstração do PI"
                            ? "Hoje"
                            : evento.name == "Primeira entrega"
                                ? "em 14 dias"
                                : "em 101 dias",
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: -1.5,
                            color: evento.theme.accentColor.withAlpha(150))),
                  ],
                )),
          )),
    );
  }
}
