import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
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
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6.resolveFrom(context),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Consumer<EventEditProvider>(builder: (context, value, child) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.event.users?.length ?? 0,
                  itemBuilder: (context, index) {
                    User user = value.event.users![index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Consumer<UserLoginProvider>(
                              builder: (context, provider, child) {
                            return RemoteProfilePicture(
                                url: provider.user?.profilePhoto,
                                size: 32);
                          }),
                          SizedBox(width: 8),
                          Text('${user.displayName}'),
                          Spacer(),
                          ElasticButton(
                            onTap: () async {
                              if (await provider.showDeletionDialog(context)) {

                              }
                            },
                            child: ButtonBar(
                              children: [
                                Icon(
                                  CupertinoIcons.delete_simple, 
                                      color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
              CupertinoButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.label, context),
                      size: 30,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "adicionar participante",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label, context),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  ModalPopup(
                    context: context,
                    title: "adicionar participante",
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           EventAddGuestRow(title: "e-mail", icon: CupertinoIcons.envelope, enabled: true,),
                           SizedBox(height: 8),
                           EventAddGuestRow(title: "QR code", icon: CupertinoIcons.qrcode, enabled: false,),
                           SizedBox(height: 8),
                           EventAddGuestRow(title: "encaminhar", icon: CupertinoIcons.share, enabled: false,),
                        ],
                      ),
                    ),
                  ).show();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EventAddGuestRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool enabled;

  const EventAddGuestRow({
    super.key,
    required this.title,
    required this.icon,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: ElasticButton(
           child: 
             Row(
               children: [
                 Container(
                   width: 50,
                   height: 50,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     color: CupertinoColors.extraLightBackgroundGray
                         .withOpacity(0.8),
                   ),
                   child: Icon(
                     icon,
                     color: CupertinoDynamicColor.resolve(
                         CupertinoColors.label, context),
                   ),
                 ),
             SizedBox(width: 8),
             Text(title,
             style:
              TextStyle(
               color: CupertinoDynamicColor.resolve(
                CupertinoColors.label, context), fontWeight: FontWeight.w500),), 
               ],
             ),
             onTap: (){},
      ),
    );
  }
}
