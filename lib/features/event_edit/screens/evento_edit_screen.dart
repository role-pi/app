import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/navigation_bar.dart';
import 'package:role/shared/widgets/round_button.dart';

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
          onPressedTrailing: () {}),
      Padding(
        padding: EdgeInsets.only(top: 12),
        child: RoundButton(
          onPressed: () async {
            EventoListProvider.shared.delete(evento, context);
          },
          textColor: const Color.fromARGB(255, 255, 255, 255),
          rectangleColor: const Color.fromARGB(255, 245, 0, 0),
          text: 'Excluir evento',
        ),
      ),
    ]));
  }
}
