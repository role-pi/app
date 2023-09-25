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
              leadingIcon: null,
              leadingText: "opções de conta",
              topPadding: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
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
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  "https://pbs.twimg.com/profile_images/1699634404291661824/Zc2OT-q4_400x400.jpg",
                                  fit: BoxFit.cover,
                                  width: 72,
                                  errorBuilder: (context, error, stackTrace) {
                                    return DefaultUserIcon(size: 72);
                                  },
                                ),
                              ),
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
                                                color: CupertinoColors.white))),
                                    child: Icon(
                                      CupertinoIcons.pencil,
                                      size: 23.0,
                                      color: CupertinoColors.label,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            CupertinoTextField(
                              placeholder: "Nome",
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey6,
                                  borderRadius: BorderRadius.circular(8.0)),
                              placeholderStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.8,
                              ),
                            ),
                            CupertinoTextField(
                              placeholder: "Email",
                              decoration: BoxDecoration(border: null),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: RoundButton(
                      onPressed: () async {
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text("Alerta!"),
                          content: const Text("Você tem certeza que deseja excluir sua conta?"),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              child: const Text("Não"),
                              isDestructiveAction: true,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ), 
                            CupertinoDialogAction(
                              child: const Text("Sim"),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            )
                          ], 
                          ),
                        );
                      },
                      rectangleColor: CupertinoColors.systemRed,
                      textColor: CupertinoColors.white,
                      text: 'excluir conta',
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: RoundButton(
                      onPressed: () async {
                        UserLoginProvider.shared.logout();
                        Navigator.pushNamed(context, "/onboarding");
                      },
                      rectangleColor: CupertinoColors.white,
                      textColor: CupertinoColors.systemRed,
                      text: 'logout',
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              onPressed: () => pickImage(ImageSource.gallery),
              child: Text("escolher da biblioteca", style: style),
            ),
            CupertinoActionSheetAction(
              onPressed: () => pickImage(ImageSource.camera),
              child: Text("tirar foto", style: style),
            ),
          ],
        );
      },
    );
  }
}
