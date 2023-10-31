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
                            onTap: (){},
                            child: ButtonBar(
                              children: [
                                Icon(
                                  CupertinoIcons.ellipsis, 
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CupertinoColors.extraLightBackgroundGray
                                    .withOpacity(0.8),
                              ),
                              child: Icon(
                                CupertinoIcons.envelope,
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                              ),
                            ),
                            Text(" Convidar por e-mail"),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CupertinoColors.extraLightBackgroundGray
                                    .withOpacity(0.8),
                              ),
                              child: Icon(
                                CupertinoIcons.qrcode,
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                              ),
                            ),
                            Text("QR CODE"),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CupertinoColors.extraLightBackgroundGray
                                    .withOpacity(0.8),
                              ),
                              child: Icon(
                                CupertinoIcons.square_arrow_up,
                                color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label, context),
                              ),
                            ),
                            Text("Encaminhar"),
                          ],
                        )
                      ],
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
