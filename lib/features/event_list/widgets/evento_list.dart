import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/domain/models/evento.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/event_list/widgets/evento_item_row.dart';
import 'package:role/features/event_list/widgets/evento_list_header.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    EventoListProvider usersViewModel = context.watch<EventoListProvider>();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: CustomScrollView(slivers: [
            CupertinoSliverRefreshControl(onRefresh: () async {
              await usersViewModel.get();
            }),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0) {
                  // Align to the left
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(38, 38, 38, 12),
                    child: HomeHeader(),
                  );
                } else {
                  Evento evento = usersViewModel.eventos[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 4.0),
                    child: EventoItemRow(
                      evento: evento,
                    ),
                  );
                }
              }, childCount: usersViewModel.eventos.length + 1),
            )
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: RoundButton(onTap: onTap),
        ),
      ],
    );
  }
}