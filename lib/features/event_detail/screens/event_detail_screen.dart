import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_edit/screens/event_map_screen.dart';
import 'package:role/features/event_detail/widgets/event_detail_guests.dart';
import 'package:role/features/event_detail/widgets/event_detail_header.dart';
import 'package:role/features/event_detail/widgets/event_detail_items.dart';
import 'package:role/features/event_detail/widgets/event_detail_map.dart';
import 'package:role/features/new_item/screens/new_item_screen.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/round_button.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen(id) : provider = EventDetailProvider(id);

  final EventDetailProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          physics: SnapScrollPhysics(snaps: [
            Snap(200, distance: 50),
            Snap(200, leadingDistance: 50),
            Snap(200, trailingDistance: 50),
            Snap(200, trailingDistance: 50),
            Snap.avoidZone(0, 200),
            Snap.avoidZone(0, 200, delimiter: 50),
          ]),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: EventDetailHeaderDelegate(event: provider.event),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: CupertinoSliverRefreshControl(onRefresh: () async {
                await provider.get();
              }),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 8.0, bottom: 64.0),
                  child: Consumer<EventDetailProvider>(
                      builder: (context, provider, child) {
                    if (provider.event.users == null ||
                        provider.event.users == null)
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 20,
                        color: CupertinoColors.label.resolveFrom(context),
                      ));
                    return Column(
                      children: [
                        EventDetailGuests(convidados: provider.event.users!),
                        SizedBox(height: 24),
                        ElasticButton(
                          child: provider.event.location != null
                              ? SizedBox(
                                  height: 210,
                                  child: EventDetailMap(
                                    color: provider.event.color2,
                                    location: provider.event.location!,
                                  ))
                              : EventMapPlaceholder(
                                  color: provider.event.color2),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    EventMapScreen(EventEditProvider(provider)),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              onPressed: () {
                                NewItemScreen(provider).show(context);
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
                        SizedBox(height: 4),
                        EventDetailItems(items: provider.event.items!),
                        RoundButton(
                          text: "distribuir gastos",
                          rectangleColor: CupertinoColors.systemGrey6,
                          textColor: CupertinoColors.label,
                          onPressed: () => provider.splitCosts(context),
                        ),
                      ],
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
