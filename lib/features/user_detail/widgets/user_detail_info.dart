import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_detail/widgets/user_detail_pix.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';
import '../../user_login/providers/user_login_provider.dart';

class UserDetailInfo extends StatelessWidget {
  UserDetailProvider get provider => UserDetailProvider.shared;
  const UserDetailInfo({
    super.key, required this.userDetailProvider,
  });
  final UserDetailProvider userDetailProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElasticButton(
                onPressed: () => provider.showImageSelectionPopup(context),
                child: SizedBox(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Consumer<UserLoginProvider>(
                          builder: (context, provider, child) {
                        return RemoteProfilePicture(
                            url: provider.user?.profilePhoto, size: 72);
                      }),
                      Positioned(
                        bottom: -6,
                        right: -6,
                        child: ClipOval(
                          child: Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: ShapeDecoration(
                                color: CupertinoColors.systemGrey5
                                    .resolveFrom(context),
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color: CupertinoColors.systemBackground
                                            .resolveFrom(context)))),
                            child: Icon(
                              CupertinoIcons.pencil,
                              size: 22.0,
                              color: CupertinoColors.label.resolveFrom(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserDetailProvider>(
                    builder: (context, value, child) {
                      return FormItemTextField(
                        controller: provider.nameController,
                        title: "nome",
                        padding: EdgeInsets.all(4.0),
                        enabled: !value.loading,
                        textSize: 16.0,
                      );
                    },
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      UserLoginProvider.shared.user?.email ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1,
                          color: CupertinoColors.secondaryLabel
                              .resolveFrom(context),
                          fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Divider(),
        SizedBox(height: 12),

       RoundButton(
          onPressed: () async {
            NewPixKeyScreen().show(context);
          }, 
          rectangleColor: CupertinoColors.systemGrey6,
          textColor: CupertinoColors.label,
          text: 'chave pix',
        ), 
      ],
    );
  }
}