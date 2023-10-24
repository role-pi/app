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
  var controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      children: [
        Container(
          color: CupertinoColors.white,
        ),
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Text(
                  "Tudo Pronto!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
               
                Text(
                  textAlign: TextAlign.center,
                  'Por último, gostaria de adicionar um nome e foto de perfil?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 98, 98, 100).withOpacity(0.8)
                ),
              ),
            ],
          )
        ) 
      ]
    );
  }
}