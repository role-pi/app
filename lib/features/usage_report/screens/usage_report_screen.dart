import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class UsageReportScreen extends StatelessWidget {
  const UsageReportScreen({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.white,
    child: Center (
      child: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(color: CupertinoColors.black),
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                    children: [
                
                      Text("Relatório de Uso", style: TextStyle(color: CupertinoColors.white, fontSize: 30)),
                      Spacer(),
                    ],),
                      Spacer(),
                      Consumer<UserLoginProvider>(builder: (context, provider, child) {
                        return RemoteProfilePicture(
                           url: provider.user?.profilePhoto, size: 100,

                    );
                  }),
                  Row(
                    children: [
                      Text("Dadinho porra", style: TextStyle(color: CupertinoColors.white, fontSize: 30))
                    ],
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}