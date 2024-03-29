import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:role/features/user_detail/screens/usage_report_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/repository/user_repository.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/custom_toast.dart';

class UserDetailProvider extends ChangeNotifier {
  static final UserDetailProvider shared = UserDetailProvider();

  bool _changed = false;
  bool get changed => _changed;

  bool _loading = false;
  bool get loading => _loading;

  UserRepository userRepository = UserRepository();

  late TextEditingController nameController, emailController, pixKeyController;

  late FToast fToast;

  UserDetailProvider() {
    nameController =
        TextEditingController(text: UserLoginProvider.shared.user?.name);
    nameController.addListener(textChanged);

    emailController =
        TextEditingController(text: UserLoginProvider.shared.user?.email);
    emailController.addListener(textChanged);

    pixKeyController =
        TextEditingController(text: UserLoginProvider.shared.user?.pixKey);
    pixKeyController.addListener(textChanged);

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

  void showImageSelectionPopup(BuildContext context) {
    TextStyle style = TextStyle(
        letterSpacing: -0.9,
        color: CupertinoColors.label.resolveFrom(context),
        fontWeight: FontWeight.bold);

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
                pickImage(ImageSource.gallery, context);
              },
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo,
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.label, context),
                    ),
                    SizedBox(width: 8),
                    Text("escolher da biblioteca", style: style),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera, context);
              },
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.camera,
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.label, context),
                    ),
                    SizedBox(width: 8),
                    Text("tirar foto", style: style),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future updateUser(BuildContext context) async {
    UserLoginProvider.shared.user!.name = nameController.text;
    // UserLoginProvider.shared.user!.email = emailController.text;
    FocusScope.of(context).unfocus();

    _loading = true;
    notifyListeners();

    int? result = await userRepository.putUser(UserLoginProvider.shared.user!);
    fToast.init(context);

    Widget toast;
    if (result != null) {
      toast = CustomToast(
          title: "usuário salvo",
          icon: CupertinoIcons.checkmark,
          color: CupertinoColors.systemGreen);

      _changed = false;
    } else {
      toast = CustomToast(
          title: "erro ao salvar usuário",
          icon: CupertinoIcons.xmark,
          color: CupertinoColors.systemRed);
    }

    _loading = false;
    notifyListeners();

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

  Future updatePixKey(BuildContext context) async {
    UserLoginProvider.shared.user!.pixKey = pixKeyController.text;
    FocusScope.of(context).unfocus();

    Navigator.pop(context);

    _loading = true;
    notifyListeners();

    await updateUser(context);

    _loading = false;
    notifyListeners();
  }

  void showReport(BuildContext context) async {
    var result = await userRepository.getUsageReport();

    if (result != null) {
      int totalEvents = result["eventos"].isNotEmpty
          ? result["eventos"][0]["eventos"] ?? 0
          : 0;

      double totalSpent = result["total"].isNotEmpty
          ? double.tryParse(result["total"][0]["total"]) ?? 0
          : 0;

      double averageSpent = totalEvents != 0 ? totalSpent / totalEvents : 0;

      ItemCategory category = result["insumos"].isNotEmpty
          ? ItemCategory.fromValue(result["insumos"][0]["categoria"])
          : ItemCategory.other;

      showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return UsageReportScreen(
                totalEvents: totalEvents,
                totalSpent: totalSpent,
                averageSpent: averageSpent,
                category: category);
          });
    }
  }

  textChanged() {
    if (nameController.text != UserLoginProvider.shared.user?.name) {
      _changed = true;
    } else {
      _changed = false;
    }
    notifyListeners();
  }
}
