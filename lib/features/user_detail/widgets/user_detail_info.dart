import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

import '../../user_login/providers/user_login_provider.dart';

class UserDetailInfo extends StatelessWidget {
  UserDetailProvider get provider => UserDetailProvider.shared;

  const UserDetailInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: ElasticButton(
            onTap: () => provider.showImageSelectionPopup(context),
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
              Consumer<UserDetailProvider>(builder: (context, value, child) {
                return FormItemTextField(
                    controller: provider.emailController,
                    title: "email",
                    padding: EdgeInsets.all(4.0),
                    enabled: !value.loading,
                    textSize: 16.0,
                    backgroundColor: CupertinoColors.systemBackground);
              })
            ],
          ),
        ),
      ],
    );
  }
}
