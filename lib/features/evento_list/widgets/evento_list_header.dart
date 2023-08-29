import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/screens/user_detail_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? CupertinoColors.white
            : CupertinoColors.black;
    final loginProvider = Provider.of<UserLoginProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? 'assets/Invertida.png'
                      : 'assets/Logo.png',
                  height: 46),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
        Spacer(),
        // Gray circle sized to fit
        ElasticButton(
          onTap: () => {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => UserDetailScreen(),
            )
          },
          child: ClipOval(
            child: Image.network(
              loginProvider.user?.profilePhoto ??
                  "https://pbs.twimg.com/profile_images/1685715309615878144/JG6PlTn5_400x400.jpg",
              fit: BoxFit.cover,
              width: 58,
            ),
          ),
        )
      ],
    );
  }
}
