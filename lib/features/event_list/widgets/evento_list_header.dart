import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_detail/screens/user_detail_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class EventListHeader extends StatelessWidget {
  const EventListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        ElasticButton(
          onTap: () => {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => UserDetailScreen(),
            )
          },
          child:
              Consumer<UserLoginProvider>(builder: (context, provider, child) {
            return RemoteProfilePicture(
                url: provider.user?.profilePhoto, size: 58);
          }),
        )
      ],
    );
  }
}
