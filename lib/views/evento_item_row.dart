import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';

class EventoItemRow extends StatefulWidget {
  const EventoItemRow({super.key});

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
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(child: Text(evento.name)),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 255, 249, 250),
                Color.fromARGB(255, 41, 41, 179)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(evento.name),
            ],
          ),
        ),
      ),
    );
  }
}
