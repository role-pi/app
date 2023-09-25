import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

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
      CustomNavigationBar(
          leadingText: "voltar",
          trailingText: "adicionar",
          accentColor: widget.evento.color1,
          onPressedLeading: () {
            Navigator.of(context).pop();
          },
          onPressedTrailing: () {})
    ]));
  }
}
