import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/default_user_icon.dart';
import 'package:role/shared/widgets/round_button.dart';

import '../../../shared/widgets/elastic_button.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool showNewEvent = false;
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;
  File? image;

  Future<void> pickImage(ImageSource gallery) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Falha ao escolher imagem $e');
    }
  }

  TextStyle style = TextStyle(
      letterSpacing: -1.0,
      color: CupertinoColors.black,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          children: [
            CustomNavigationBar(
              leadingText: "opções de conta",
              leadingIcon: null,
              topPadding: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElasticButton(
                          onTap: () {
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
                                      style: style.copyWith(
                                          color: CupertinoColors.systemRed),
                                    ),
                                  ),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () =>
                                          pickImage(ImageSource.gallery),
                                      child: Text("escolher da biblioteca",
                                          style: style),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () =>
                                          pickImage(ImageSource.camera),
                                      child: Text("tirar foto", style: style),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: DefaultUserIcon()),
                      SizedBox(width: 20),
                      Expanded(
                        child: CupertinoTextField(
                          placeholder: "Nome de Usuário",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: evento.email,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 80,
              child: RoundButton(
                onPressed: () async {
                  UserLoginProvider.shared.logout();
                  Navigator.pushNamed(context, "/onboarding");
                },
                rectangleColor: CupertinoColors.systemRed,
                textColor: CupertinoColors.white,
                text: 'logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
