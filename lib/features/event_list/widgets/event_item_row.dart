import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/event_list_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/gradient_effect.dart';

import 'event_item_row_guests.dart';

class EventItemRow extends StatelessWidget {
  EventItemRow({required this.event, this.onTap});

  final Event event;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElasticButton(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/event",
          arguments: event.id,
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Dismissible(
            key: Key(event.id.toString()),
            direction: DismissDirection.endToStart,
            background: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: CupertinoColors.destructiveRed,
                        borderRadius: BorderRadius.circular(16))),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    CupertinoIcons.trash,
                    color: CupertinoColors.white,
                    size: 48,
                  ),
                ),
              ],
            ),
            onDismissed: (direction) {
              EventListProvider.shared.delete(event, context);
            },
            child: GradientWidget(
              color1: CupertinoDynamicColor.resolve(event.color1, context),
              color2: CupertinoDynamicColor.resolve(event.color2, context),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          event.emoji.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(event.emoji,
                                      style: TextStyle(
                                          fontSize: 52,
                                          fontWeight: FontWeight.bold)),
                                )
                              : SizedBox(height: 60),
                          Spacer(),
                          ContainerText(
                              text: "R\$ " + event.valorTotal.toString(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
                              size: 21),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(event.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -1.5,
                                        color: CupertinoDynamicColor.resolve(
                                                event.theme.accentColor,
                                                context)
                                            .withAlpha(200))),
                                AutoSizeText(event.shortDescription,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 22,
                                        letterSpacing: -1.5,
                                        color: CupertinoDynamicColor.resolve(
                                                event.theme.accentColor,
                                                context)
                                            .withAlpha(150))),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          EventItemRowGuests(event: event),
                        ],
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
