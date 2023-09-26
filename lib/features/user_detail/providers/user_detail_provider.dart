import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/models/usuario.dart';

class UserDetailProvider extends ChangeNotifier {
  bool _loading = false;

  static final UserDetailProvider shared = UserDetailProvider();

  late TextEditingController nameController, emailController;

  bool get loading => _loading;

  UserDetailProvider() {
    nameController =
        TextEditingController(text: UserLoginProvider.shared.user?.name);
    emailController =
        TextEditingController(text: UserLoginProvider.shared.user?.email);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future pickImage(ImageSource gallery) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      await updateImage(imageTemporary);
    } on PlatformException catch (e) {
      print('Falha ao escolher imagem $e');
    }
  }

  Future updateImage(File image) async {}

  delete(Evento evento, BuildContext context) async {
    // await EventoListProvider.shared.delete(evento, context);
  }
}
