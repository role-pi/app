import 'package:flutter/cupertino.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/models/location.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';

class EventMapScreen extends StatelessWidget {
  Color color;
  Location endereco;

  EventMapScreen({required this.color, required this.endereco});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          CustomNavigationBar(
              leadingText: "voltar",
              trailingIcon: CupertinoIcons.pencil,
              onPressedLeading: () {
                Navigator.of(context).pop();
              },
              onPressedTrailing: () {}),
          Expanded(child: EventoStyledMap(color: color, endereco: endereco)),
        ],
      ),
    );
  }
}