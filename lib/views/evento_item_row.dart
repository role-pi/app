import 'package:flutter/cupertino.dart';
import 'package:role/models/evento.dart';

class EventoItemRow extends StatelessWidget {
  final Evento evento;
  final Function()? onTap;

  const EventoItemRow({required this.evento, this.onTap});

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
