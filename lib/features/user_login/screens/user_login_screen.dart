import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';

class UserLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginProvider>(context);
    Future(loginProvider.tryLogin);

    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () async {
            Navigator.pushNamed(context, "/");
          },
          child: const Text('Entrar'),
        ),
      ),
      backgroundColor: CupertinoColors.black,
    );
  }
}
