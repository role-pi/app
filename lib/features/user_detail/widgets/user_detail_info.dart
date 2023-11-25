import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_detail/widgets/user_detail_pix.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_group_title.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailInfo extends StatelessWidget {
  const UserDetailInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailProvider provider = Provider.of<UserDetailProvider>(context);

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
                        },
                      ),
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
                                        .resolveFrom(context),
                                  ),
                                )),
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
                        color:
                            CupertinoColors.secondaryLabel.resolveFrom(context),
                        fontSize: 17,
                      ),
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
        FormItemGroupTitle(title: "chave pix"),
        RoundButton(
          onPressed: () async {
            NewPixKeyScreen(
              provider: provider,
            ).show(context);
          },
          icon: CupertinoIcons.money_dollar,
          rectangleColor: CupertinoColors.systemGrey6,
          textColor: CupertinoColors.secondaryLabel,
          text: UserLoginProvider.shared.user?.pixKey ?? "adicionar",
        ),
      ],
    );
  }
}
