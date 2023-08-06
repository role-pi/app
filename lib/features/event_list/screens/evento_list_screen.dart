import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/domain/models/evento.dart';
import 'package:role/features/event_list/widgets/evento_item_row.dart';

import '../widgets/evento_list_header.dart';
import '../../../shared/widgets/round_button.dart';

class EventoListScreen extends StatefulWidget {
  @override
  _EventoListScreenState createState() => _EventoListScreenState();
}

class _EventoListScreenState extends State<EventoListScreen> {
  bool showNewEvent = false;

  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventoListProvider(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          child: Center(
            child: Stack(
              children: [
                EventsList(
                  onTap: () => {
                    setState(() {
                      showNewEvent = !showNewEvent;
                    })
                  },
                ),
                IgnorePointer(
                  ignoring: true,
                  child: ClipRect(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: showNewEvent ? 0 : 10,
                          end: showNewEvent ? 10 : 0),
                      duration: duration,
                      curve: curve,
                      builder: (_, value, __) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: value,
                            sigmaY: value,
                          ),
                          child: AnimatedOpacity(
                            opacity: showNewEvent ? 0.6 : 0.0,
                            duration: duration,
                            curve: curve,
                            child: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemBackground,
                              ),
                              child: Center(
                                child: Text('novo evento'),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              usersViewModel.get();
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
