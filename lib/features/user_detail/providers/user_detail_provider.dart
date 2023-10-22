import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/repository/user_repository.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class UserDetailProvider extends ChangeNotifier {
  static final UserDetailProvider shared = UserDetailProvider();

  UserRepository userRepository = UserRepository();

  late TextEditingController nameController, emailController;

  late FToast fToast;

  UserDetailProvider() {
    nameController =
        TextEditingController(text: UserLoginProvider.shared.user?.name);
    emailController =
        TextEditingController(text: UserLoginProvider.shared.user?.email);
    fToast = FToast();
  }

  Future pickImage(ImageSource gallery, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: gallery);
      if (image == null) return;

      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.jpg);

      if (croppedFile == null) return;
      await updateImage(File(croppedFile.path), context);
    } on PlatformException catch (e) {
      print('Falha ao escolher imagem $e');
    }
  }

  Future updateUsuario(BuildContext context) async {
    UserLoginProvider.shared.user!.name = nameController.text;
    UserLoginProvider.shared.user!.email = emailController.text;
    int? result =
        await userRepository.putUsuario(UserLoginProvider.shared.user!);

    fToast.init(context);
    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "usuario salvo",
          icon: CupertinoIcons.checkmark,
          color: CupertinoColors.systemGreen);
    } else {
      toast = CustomToast(
          title: "erro ao salvar usuario",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  Future updateImage(File image, BuildContext context) async {
    String? url = await userRepository.uploadImage(image);

    fToast.init(context);
    Widget toast;
    if (url != null) {
      UserLoginProvider.shared.user!.profilePhoto = url;
      UserLoginProvider.shared.notifyListeners();

      toast = CustomToast(
          title: "imagem atualizada",
          icon: CupertinoIcons.checkmark,
          color: CupertinoColors.systemGreen);
    } else {
      toast = CustomToast(
          title: "erro ao atualizar imagem",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  delete(Event event, BuildContext context) async {}
}
