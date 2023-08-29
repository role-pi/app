import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:role/features/evento_list/widgets/evento_item_row.dart';
import 'package:role/features/evento_list/widgets/evento_list_header.dart';
import 'package:role/shared/widgets/circle_button.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    EventoListProvider usersViewModel = context.watch<EventoListProvider>();
    Color backgroundColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 68),
          child: CustomScrollView(slivers: [
            CupertinoSliverRefreshControl(onRefresh: () async {
              await usersViewModel.get();
            }),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 138.0, top: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(36, 36, 38, 16),
                      child: HomeHeader(),
                    );
                  } else {
                    if (usersViewModel.eventos.length == 0) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 4.0),
                          child: Opacity(
                              opacity: 0.5,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey6,
                                      border: Border.all(
                                          color: CupertinoColors.systemGrey5,
                                          width: 4),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 48),
                                    child: Text(
                                      "crie um evento com o botão de estrela logo abaixo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))));
                    } else {
                      Evento evento = usersViewModel.eventos[index - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 4.0),
                        child: EventoItemRow(
                          evento: evento,
                        ),
                      );
                    }
                  }
                },
                    childCount: (usersViewModel.eventos.length == 0
                            ? 1
                            : usersViewModel.eventos.length) +
                        1),
              ),
            )
          ]),
        ),
        IgnorePointer(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                backgroundColor.withOpacity(0),
                backgroundColor.withOpacity(0),
                backgroundColor.withOpacity(0.2),
                backgroundColor.withOpacity(0.9)
              ]))),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: CircleButton(onTap: onTap),
        ),
      ],
    );
  }
}
