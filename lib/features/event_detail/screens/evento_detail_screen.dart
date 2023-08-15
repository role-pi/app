import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/domain/models/evento.dart';

class EventoDetailScreen extends StatefulWidget {
  const EventoDetailScreen({
    super.key,
    required this.evento,
  });

  final Evento evento;

  @override
  State<EventoDetailScreen> createState() => _EventoDetailScreenState();
}

class _EventoDetailScreenState extends State<EventoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(child: Text(widget.evento.name)));
  }
}
