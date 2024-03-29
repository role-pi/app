import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/new_event/providers/new_event_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/features/event_list/widgets/event_item_row.dart';
import 'package:role/features/event_list/widgets/event_list_header.dart';
import 'package:role/shared/widgets/circle_button.dart';
import 'package:role/shared/widgets/empty_list_indicator.dart';

class EventList extends StatelessWidget {
  const EventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventListProvider usersViewModel = context.watch<EventListProvider>();

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
                padding: EdgeInsets.fromLTRB(36, 44, 38, 16),
                sliver: SliverToBoxAdapter(
                  child: EventListHeader(),
                )),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 138.0, top: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: (usersViewModel.events.length == 0
                        ? 1
                        : usersViewModel.events.length), (context, index) {
                  if (usersViewModel.events.length == 0) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 4.0),
                        child: EmtpyListIndicator(
                          text: "crie um evento com o botão de estrela abaixo",
                        ));
                  } else {
                    Event event = usersViewModel.events[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 6.0),
                      child: EventItemRow(
                        event: event,
                      ),
                    );
                  }
                }),
              ),
            )
          ]),
        ),
        FadedBackgroundWidget(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: CircleButton(onTap: () {
            NewEventProvider.shared.showing = true;
          }),
        ),
      ],
    );
  }
}

class FadedBackgroundWidget extends StatelessWidget {
  const FadedBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = CupertinoDynamicColor.resolve(
        CupertinoColors.systemBackground, context);

    return IgnorePointer(
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
    );
  }
}
