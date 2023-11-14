import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_edit/screens/add_guests_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/user.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class EventEditGuests extends StatelessWidget {
  const EventEditGuests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventEditProvider provider =
        Provider.of<EventEditProvider>(context, listen: false);

    return Column(
      children: [
        Consumer<EventEditProvider>(builder: (context, value, child) {
          return FormItemGroupTitle(
              title: value.event.usersString.toUpperCase());
        }),
        SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.resolveFrom(context),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<EventEditProvider>(
                        builder: (context, value, child) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.event.users?.length ?? 0,
                        itemBuilder: (context, index) {
                          User user = value.event.users![index];
                          return Column(children: [
                            Row(
                              children: [
                                Consumer<UserLoginProvider>(
                                    builder: (context, provider, child) {
                                  return RemoteProfilePicture(
                                      url: provider.user?.profilePhoto,
                                      size: 36);
                                }),
                                SizedBox(width: 8),
                                Text('${user.displayName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.5)),
                                Spacer(),
                                ElasticButton(
                                  onPressed: () async {
                                    if (await provider
                                        .showDeletionDialog(context)) {}
                                  },
                                  child: ButtonBar(
                                    children: [
                                      Icon(
                                        CupertinoIcons.delete_simple,
                                        size: 22,
                                        color: CupertinoDynamicColor.resolve(
                                            CupertinoColors.secondaryLabel,
                                            context),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height: index == value.event.users!.length - 1
                                    ? 0
                                    : 16),
                          ]);
                        },
                      );
                    }),
                  ),
                  Container(
                    color: provider.event.color1.withOpacity(0.1),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: CupertinoDynamicColor.resolve(
                                provider.event.color1.withOpacity(0.5),
                                context),
                            size: 24,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "adicionar participante",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CupertinoDynamicColor.resolve(
                                    provider.event.color1, context),
                                letterSpacing: -0.8),
                          ),
                        ],
                      ),
                      onPressed: () {
                        ModalPopup(
                          context: context,
                          title: "adicionar participante",
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                32.0, 0.0, 32.0, 32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                EventAddGuestRow(
                                  title: "e-mail",
                                  description:
                                      "Convide um usuário pelo seu e-mail ou nome",
                                  icon: CupertinoIcons.envelope,
                                  enabled: true,
                                ),
                                SizedBox(height: 24),
                                EventAddGuestRow(
                                  title: "QR code",
                                  description:
                                      "Convide um usuário por meio de um QR code de evento",
                                  icon: CupertinoIcons.qrcode,
                                  enabled: false,
                                ),
                                SizedBox(height: 24),
                                EventAddGuestRow(
                                  title: "encaminhar",
                                  description:
                                      "Convide um usuário por meio de um link de ingresso",
                                  icon: CupertinoIcons.share,
                                  enabled: false,
                                ),
                              ],
                            ),
                          ),
                        ).show();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventAddGuestRow extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool enabled;

  const EventAddGuestRow({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: ElasticButton(
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    CupertinoColors.extraLightBackgroundGray.withOpacity(0.8),
              ),
              child: Icon(
                icon,
                color: CupertinoDynamicColor.resolve(
                    CupertinoColors.label, context),
                size: 28,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label, context),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.secondaryLabel, context),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pop();
          showCupertinoModalBottomSheet(
              context: context,
              builder: (context) {
                return AddGuestsScreen();
              });
        },
      ),
    );
  }
}
