import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';

import '../../../shared/widgets/elastic_button.dart';

class UserDetailScreen extends StatelessWidget {
  UserDetailProvider userDetailProvider = UserDetailProvider.shared;

  File? image;

  TextStyle style = TextStyle(
      letterSpacing: -0.8,
      color: CupertinoColors.black,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userDetailProvider,
      child: CupertinoPageScaffold(
        child: Center(
          child: Column(
            children: [
              CustomNavigationBar(
                leadingIcon: null,
                leadingText: "opções de conta",
                trailingText: "salvar",
                accentColor: CupertinoColors.activeBlue,
                onPressedTrailing: () {
                  userDetailProvider.updateUsuario(context);
                },
                topPadding: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 250,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: ElasticButton(
                              onTap: () {
                                showPopup(context);
                              },
                              child: SizedBox(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Consumer<UserLoginProvider>(
                                        builder: (context, provider, child) {
                                      return RemoteProfilePicture(
                                          url: provider.user?.profilePhoto,
                                          size: 72);
                                    }),
                                    Positioned(
                                      bottom: -4,
                                      right: -4,
                                      child: ClipOval(
                                        child: Container(
                                          width: 35.0,
                                          height: 35.0,
                                          decoration: ShapeDecoration(
                                              color: CupertinoColors
                                                  .extraLightBackgroundGray,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: CupertinoColors
                                                          .white))),
                                          child: Icon(
                                            CupertinoIcons.pencil,
                                            size: 22.0,
                                            color: CupertinoColors.label,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              children: [
                                FormItemTextField(
                                  controller: userDetailProvider.nameController,
                                  title: "Nome",
                                  padding: EdgeInsets.all(4.0),
                                  textSize: 16.0,
                                ),
                                FormItemTextField(
                                    controller:
                                        userDetailProvider.emailController,
                                    title: "Email",
                                    padding: EdgeInsets.all(4.0),
                                    textSize: 16.0,
                                    backgroundColor:
                                        CupertinoColors.systemBackground),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: RoundButton(
                          onPressed: () {},
                          rectangleColor: CupertinoColors.systemGrey6,
                          textColor: CupertinoColors.black,
                          text: 'relatório de uso',
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 60,
                        child: RoundButton(
                          onPressed: () async {
                            showCupertinoDialog<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text("tem certeza?"),
                                content: const Text(
                                    "a exclusão de conta é uma ação irreversível"),
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                      child: const Text("voltar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      textStyle: style),
                                  CupertinoDialogAction(
                                    child: const Text("excluir conta"),
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    textStyle: style.copyWith(
                                        color: CupertinoColors.destructiveRed),
                                  )
                                ],
                              ),
                            );
                          },
                          rectangleColor: CupertinoColors.systemRed,
                          textColor: CupertinoColors.white,
                          text: 'excluir conta',
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: 60,
                            child: RoundButton(
                              onPressed: () async {
                                UserLoginProvider.shared.logout();
                                Navigator.pushNamed(context, "/onboarding");
                              },
                              rectangleColor: CupertinoColors.systemGrey6,
                              textColor: CupertinoColors.systemRed,
                              text: 'log out',
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            "desenvolvido no ifsc gaspar",
                            style: TextStyle(
                                color: CupertinoColors.secondaryLabel,
                                letterSpacing: -1.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "2023 © rolê",
                            style: TextStyle(
                                color: CupertinoColors.secondaryLabel,
                                letterSpacing: -1.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPopup(
    BuildContext context,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "cancelar",
              style: style.copyWith(color: CupertinoColors.systemRed),
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                userDetailProvider.pickImage(ImageSource.gallery, context);
              },
              child: Text("escolher da biblioteca", style: style),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                userDetailProvider.pickImage(ImageSource.camera, context);
              },
              child: Text("tirar foto", style: style),
            ),
          ],
        );
      },
    );
  }
}
