import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool showNewEvent = false;

  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
          child: SizedBox(
        width: 200,
        height: 80,
        child: RoundButton(
          onPressed: () async {
            UserLoginProvider.shared.logout();
            Navigator.pushNamed(context, "user_login_screen.dart");
          },
          rectangleColor: CupertinoColors.systemRed,
          textColor: CupertinoColors.white,
          text: 'logout',
        ),
      )),
      backgroundColor: CupertinoColors.white,
    );
  }
}
