import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/widgets/verification_widget.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/widgets/signup_widget.dart';

class UserFirstLoginScreen extends StatefulWidget {
  @override
  State<UserFirstLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserFirstLoginScreen> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Column(
        children: [],
      )
    );
  }
}