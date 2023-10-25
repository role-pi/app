import 'package:flutter/cupertino.dart';
import 'package:role/features/item_detail/screens/item_detail_screen.dart';
import 'package:role/models/item.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/container_text.dart';

class EventDetailItems extends StatelessWidget {
  final List<Item> items;

  EventDetailItems({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 8, bottom: 16),
          child: ElasticButton(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => ItemsDetail(
                        item: items[index],
                      )));
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
                                items[index].tipo.emoji,
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
                                child: Consumer<UserLoginProvider>(
                                    builder: (context, provider, child) {
                                  return RemoteProfilePicture(
                                      url: provider.user?.profilePhoto,
                                      size: 32);
                                })),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[index].nome,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.0,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "há 2 horas",
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
              SizedBox(width: 12),
              Spacer(),
              ContainerText(text: "R\$ 60"),
            ]),
          ),
        );
      },
    );
  }
}
