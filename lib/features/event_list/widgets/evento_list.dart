import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/models/event.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/event_list/widgets/evento_item_row.dart';
import 'package:role/features/event_list/widgets/evento_list_header.dart';
import 'package:role/shared/widgets/circle_button.dart';

class EventoList extends StatelessWidget {
  const EventoList({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    EventoListProvider usersViewModel = context.watch<EventoListProvider>();
    Color backgroundColor = CupertinoDynamicColor.resolve(
        CupertinoColors.systemBackground, context);

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
                delegate: SliverChildBuilderDelegate(
                    childCount: (usersViewModel.eventos.length == 0
                            ? 1
                            : usersViewModel.eventos.length) +
                        1, (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(36, 36, 38, 16),
                      child: EventoListHeader(),
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
                                      color: CupertinoDynamicColor.resolve(
                                          CupertinoColors.systemGrey6, context),
                                      border: Border.all(
                                          color: CupertinoDynamicColor.resolve(
                                              CupertinoColors.systemGrey5,
                                              context),
                                          width: 4),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 48),
                                    child: Text(
                                      "crie um evento com o botão de estrela logo abaixo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ))));
                    } else {
                      Event evento = usersViewModel.eventos[index - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 6.0),
                        child: EventoItemRow(
                          evento: evento,
                        ),
                      );
                    }
                  }
                }),
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
