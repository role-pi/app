import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/widgets/verification_widget.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/widgets/signup_widget.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class UserFirstLoginScreen extends StatefulWidget {
  @override
  State<UserFirstLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserFirstLoginScreen> {
  String? email;
  var controller= TextEditingController()

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: CupertinoColors.white,
        ),
        Column(
          children: [
            FormItemTextField (
              controller: controller,
              title: "Email",
              padding: EdgeInsets.all(4.0),
              textSize: 16.0,
              backgroundColor:
              CupertinoColors.systemBackground, decoration: null,),
          ]
             )
          ],
        )
      ],
    );
  }
}