import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/widgets/verification_widget.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/widgets/signup_widget.dart';

class UserLoginScreen extends StatefulWidget {
  String? email;

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginProvider>(context);
    // loginProvider.tryAuthentication(() => Navigator.pushNamed(context, "/"));

    if (loginProvider.state == LoginState.loggedOut) {
      return CupertinoPageScaffold(
        child: Center(
            child: CupertinoActivityIndicator(
          radius: 20,
          color: CupertinoColors.black,
        )),
        backgroundColor: CupertinoColors.white,
      );
    } else {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.white,
        ),
        child: CupertinoPageScaffold(
          child: Padding(
              padding: const EdgeInsets.all(42.0),
              child: loginProvider.state == LoginState.signUp
                  ? SignUpWidget(
                      onTap: (email) async {
                        widget.email = email;
                        await loginProvider.trySignUp(email, () {});
                      },
                    )
                  : VerificationWidget(
                      onTap: (code) async {
                        await loginProvider.verify(widget.email, code, () {
                          Navigator.pushNamed(context, "/");
                        });
                      },
                    )),
          backgroundColor: CupertinoColors.black,
        ),
      );
    }
  }
}
