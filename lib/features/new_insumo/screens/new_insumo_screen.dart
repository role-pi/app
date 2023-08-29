import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/gradient_effect.dart';
import 'package:role/shared/widgets/navigation_bar.dart';

class NewInsumoScreen extends StatefulWidget {
  NewInsumoScreen({required this.id}) {
    evento = EventoListProvider.shared.evento(id);
  }

  final int id;
  late Evento evento;

  @override
  State<NewInsumoScreen> createState() => _NewInsumoScreenState();
}

class _NewInsumoScreenState extends State<NewInsumoScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(children: [
      NavigationBar(
          leadingText: "voltar",
          trailingIcon: CupertinoIcons.star_fill,
          onPressedLeading: () {},
          onPressedTrailing: () {})
    ]));
  }
}
