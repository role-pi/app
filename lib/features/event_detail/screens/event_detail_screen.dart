import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_detail/screens/event_map_screen.dart';
import 'package:role/features/event_detail/widgets/event_detail_guests.dart';
import 'package:role/features/event_detail/widgets/event_detail_header.dart';
import 'package:role/features/event_detail/widgets/event_detail_items.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/features/new_item/screens/new_item_screen.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({required this.id})
      : eventDetailProvider = EventDetailProvider(EventListProvider.shared, id);

  final int id;
  final EventDetailProvider eventDetailProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: eventDetailProvider,
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate:
                  EventoDetailHeaderDelegate(event: eventDetailProvider.event),
            ),
            CupertinoSliverRefreshControl(onRefresh: () async {
              await eventDetailProvider.get();
            }),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Consumer<EventDetailProvider>(
                      builder: (context, provider, child) {
                        if (provider.event.users != null) {
                          return EventDetailGuests(
                              convidados: provider.event.users!);
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 24),
                    ElasticButton(
                      child: SizedBox(
                        height: 200,
                        child: EventDetailMap(
                          color: eventDetailProvider.event.color2,
                          endereco: eventDetailProvider.event.endereco,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EventMapScreen(
                              color: eventDetailProvider.event.color2,
                              endereco: eventDetailProvider.event.endereco,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insumos",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                          ),
                        ),
                        ElasticButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      NewItemScreen(eventDetailProvider)),
                            );
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.systemGrey6, context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              color: CupertinoDynamicColor.resolve(
                                  CupertinoColors.label, context),
                              size: 30,
                            ),
                          ),
                        ),
                        // EventDetailInputs(),
                      ],
                    ),
                    SizedBox(height: 24),
                    Consumer<EventDetailProvider>(
                      builder: (context, provider, child) {
                        if (provider.event.items != null) {
                          return EventDetailItems(items: provider.event.items!);
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
