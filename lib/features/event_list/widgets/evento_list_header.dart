import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/screens/user_detail_screen.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset('assets/Logo.png', height: 46),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "próximos eventos",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black.withAlpha((255 * 0.2).toInt()),
                    letterSpacing: -1.5),
              ),
            ),
          ],
        ),
        Spacer(),
        // Gray circle sized to fit
        GestureDetector(
          onTap: () => {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => UserDetailScreen(),
            )
          },
          child: ClipOval(
            child: Image.network(
              "https://pbs.twimg.com/profile_images/1685715309615878144/JG6PlTn5_400x400.jpg",
              fit: BoxFit.cover,
              width: 64,
            ),
          ),
        )
      ],
    );
  }
}
