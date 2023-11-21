import 'package:flutter/cupertino.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailExtras extends StatelessWidget {
  const UserDetailExtras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundButton(
          onPressed: () async {
            UserLoginProvider.shared.logout();
            Navigator.pushNamed(context, "/onboarding");
          },
          rectangleColor: CupertinoColors.systemGrey5,
          textColor: CupertinoColors.systemRed,
          text: 'log out',
        ),
        SizedBox(height: 6),
        Text(
          "desenvolvido no ifsc gaspar",
          style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              letterSpacing: -1.0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
        Text(
          "2023 © rolê",
          style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              letterSpacing: -1.0,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
