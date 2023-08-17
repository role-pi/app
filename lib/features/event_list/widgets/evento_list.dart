import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/event_list/widgets/evento_item_row.dart';
import 'package:role/features/event_list/widgets/evento_list_header.dart';
import 'package:role/shared/widgets/circle_button.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

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
            SliverPadding(
              padding: EdgeInsets.only(bottom: 138.0),
              sliver: SliverList(
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
              ),
            )
          ]),
        ),
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
              CupertinoColors.white.withOpacity(0.6),
              CupertinoColors.white.withAlpha(0)
            ]))),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: CircleButton(onTap: onTap),
        ),
      ],
    );
  }
}
