import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/features/event_detail/widgets/event_detail_item_row.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/empty_list_indicator.dart';

class EventDetailItems extends StatelessWidget {
  final List<Item> items;

  EventDetailItems({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length == 0 ? 1 : items.length,
      itemBuilder: (context, index) {
        if (items.length == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: EmtpyListIndicator(text: "não há insumos"),
          );
        }

        bool isSameDate = true;
        final DateTime date = items[index].data;
        final item = items[index];

        if (index == 0) {
          isSameDate = false;
        } else {
          final DateTime prevDate = items[index - 1].data;
          isSameDate = DateUtils.isSameDay(date, prevDate);
        }

        if (index == 0 || !(isSameDate)) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  item.dayDescription.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.8,
                      color:
                          CupertinoColors.secondaryLabel.resolveFrom(context)),
                ),
                SizedBox(height: 12),
                EventDetailItemRow(item: item)
              ]);
        } else {
          return EventDetailItemRow(item: item);
        }
      },
    );
  }
}
