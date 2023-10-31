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
              height: 200,
              child: Row(
              children: [
                Padding(padding: EdgeInsets.all(12)),
                Text("Relatório de Uso", style: TextStyle(color: CupertinoColors.white),),
                Spacer(),
                Consumer<UserLoginProvider>(builder: (context, provider, child) {
            return RemoteProfilePicture(
                url: provider.user?.profilePhoto, size: 58);             // Fazer a Foto em uma Colum
          })
              ],

            ), decoration: BoxDecoration(color: CupertinoColors.black),),
          ],
        )
        ),
    );
  }
}