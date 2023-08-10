import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/domain/models/evento.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

class EventoItemRow extends StatefulWidget {
  EventoItemRow({required this.evento, this.onTap});

  final Evento evento;
  final Function()? onTap;
  @override
  State<EventoItemRow> createState() => EventoItemRowState();
}

class EventoItemRowState extends State<EventoItemRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(
                child: Center(child: Text(widget.evento.name))),
          ),
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
                        Container(
                          decoration: BoxDecoration(
                              color: CupertinoColors.white.withAlpha(30),
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "R\$ " + widget.evento.valor.toString(),
                            style: TextStyle(
                                fontSize: 19,
                                letterSpacing: -1.5,
                                color: CupertinoColors.white.withAlpha(180),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
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
