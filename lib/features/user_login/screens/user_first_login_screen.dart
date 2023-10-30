import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/providers/user_detail_provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/blur_overlay.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserFirstLoginScreen extends StatelessWidget {
  UserDetailProvider get provider => UserDetailProvider.shared;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLoginProvider>(
      builder: (context, value, child) {
        return BlurOverlay(
            showing: value.state == LoginState.showFirstLogin,
            onDismiss: () {
              value.state == LoginState.loggedIn;
            },
            child: child!);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(42.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "tudo pronto! ",
                  style: TextStyle(
                    color: CupertinoColors.label,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: -1.6,
                    height: 1.1,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            "por último, gostaria de adicionar um nome e foto de perfil?",
                        style:
                            TextStyle(color: CupertinoColors.secondaryLabel)),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Consumer<UserLoginProvider>(builder: (context, value, child) {
                    return ElasticButton(
                      onTap: () => provider.showImageSelectionPopup(context),
                      child:
                          RemoteProfilePicture(url: value.user?.profilePhoto),
                    );
                  }),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: FormItemTextField(
                        controller: provider.nameController, title: "nome"),
                  )
                ],
              ),
              SizedBox(height: 32),
              RoundButton(
                text: "finalizar",
                onPressed: () {
                  UserLoginProvider.shared.setState(LoginState.loggedIn);
                  provider.updateUser(context);
                },
                rectangleColor: Colors.black,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
