import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/utils/utils.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/default_user_icon.dart';
import 'package:role/shared/widgets/dismissible_exclusion_background.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class EventDetailItemRow extends StatelessWidget {
  const EventDetailItemRow({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    EventDetailProvider provider =
        Provider.of<EventDetailProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: DismissibleExclusionBackground(size: 28),
        onDismissed: (direction) async =>
            await provider.deleteItem(item, context),
        confirmDismiss: (direction) async =>
            await provider.showDeletionDialog(context),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 4),
          child: ElasticButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/event/${provider.event.id}/item/${item.id}",
              );
            },
            child: Row(children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            CupertinoIcons.bubble_left_fill,
                            color: CupertinoColors.systemGrey5
                                .resolveFrom(context),
                            size: 58,
                          ),
                          Positioned(
                              bottom: 9,
                              right: 8,
                              child: Text(
                                item.category.emoji,
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              )),
                          Positioned(
                            right: 32,
                            bottom: 6,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CupertinoColors.systemBackground
                                        .resolveFrom(context),
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: DefaultUserIcon(
                                  size: 32,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      item.name,
                      maxLines: 1,
                      minFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                      ),
                    ),
                    SizedBox(height: 2),
                    AutoSizeText(
                      item.dateDescription,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: -1.0,
                        fontWeight: FontWeight.w600,
                        color:
                            CupertinoColors.secondaryLabel.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              ContainerText(text: formatCurrency(item.amount)),
            ]),
          ),
        ),
      ),
    );
  }
}
