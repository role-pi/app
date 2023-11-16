import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/add_guests_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class AddGuestSearchResultItem extends StatelessWidget {
  const AddGuestSearchResultItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    AddGuestsProvider provider = Provider.of<AddGuestsProvider>(
      context,
      listen: false,
    );

    return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ElasticButton(
          onPressed: () {
            provider.toggle(index);
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6.resolveFrom(context),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Consumer<AddGuestsProvider>(
                      builder: (context, provider, child) {
                    return RemoteProfilePicture(
                        url: provider.users[index].user.profilePhoto, size: 48);
                  }),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(provider.users[index].user.displayName,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.5,
                                fontSize: 21)),
                        AutoSizeText(provider.users[index].user.email,
                            maxLines: 1,
                            style: TextStyle(
                                color: CupertinoColors.systemGrey2
                                    .resolveFrom(context),
                                fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                      provider.users[index].selected
                          ? CupertinoIcons.checkmark_circle_fill
                          : CupertinoIcons.checkmark_circle,
                      color: provider.event.color1,
                      size: 32),
                ],
              )),
        ));
  }
}
