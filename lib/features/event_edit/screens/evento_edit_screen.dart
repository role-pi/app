import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/navigation_bar.dart';

class EventoEditScreen extends StatelessWidget {
  EventoEditScreen({required this.id}) {
    evento = EventoListProvider.shared.evento(id);
  }

  final int id;
  late Evento evento;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(children: [
      NavigationBar(
          leadingText: "voltar",
          trailingIcon: CupertinoIcons.star_fill,
          onPressedLeading: () {
            Navigator.of(context).pop();
          },
          onPressedTrailing: () {})
    ]));
  }
}
