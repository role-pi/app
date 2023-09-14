import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Detalhes do Usuário'),
      ),
      child: Center(
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
                              "Cancelar",
                              style: TextStyle(
                                color: CupertinoColors.systemRed,
                              ),
                            ),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () => pickImage(ImageSource.gallery),
                              child: Text("Escolher da biblioteca"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () => pickImage(ImageSource.camera),
                              child: Text("Tirar foto"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ClipOval(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: CupertinoColors.lightBackgroundGray,
                      child: Center(
                        child: image != null
                            ? Image.file(
                                image!,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                CupertinoIcons.person_fill,
                                color: CupertinoColors.black,
                                size: 50.0,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: "Nome de Usuário",
                  ),
                ),
              ],
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
