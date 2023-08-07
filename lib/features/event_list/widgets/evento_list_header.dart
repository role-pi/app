import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserLoginProvider userLoginProvider =
        Provider.of<UserLoginProvider>(context);

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset('assets/Logo.png', height: 50),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "próximos eventos",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black.withAlpha((255 * 0.2).toInt()),
                    letterSpacing: -1.5),
              ),
            ),
          ],
        ),
        Spacer(),
        Text(userLoginProvider.user?.name ?? "Sem nome")
      ],
    );
  }
}
