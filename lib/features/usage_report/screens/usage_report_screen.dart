import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/container_text.dart';
import 'package:role/shared/widgets/remote_profile_picture.dart';

class UsageReportScreen extends StatelessWidget {
  const UsageReportScreen({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.white,
    child: Center (
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(color: CupertinoColors.black),
            padding: EdgeInsets.fromLTRB(30, 100, 30, 30),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                      children: [
                
                      Text("Relatório de Uso", style: TextStyle(color: CupertinoColors.white, fontSize: 30)),
                      ],),

                      Spacer(),
                      Consumer<UserLoginProvider>(builder: (context, provider, child) {
                        return RemoteProfilePicture(
                           url: provider.user?.profilePhoto, size: 100,
                      

                    );
                  }),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text(UserLoginProvider.shared.user?.displayName ?? "Usuário", style: TextStyle(color: CupertinoColors.white, fontSize: 30))
                    ],
                  ),
                  SizedBox(height: 15,),
                  ContainerText(text: "Membro desde 2020")
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 15, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("no total você participou de", style: TextStyle(color: const Color.fromARGB(255, 110, 109, 109), fontSize: 25),),
                  SizedBox(height: 8),
                  Text("12 eventos", style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Os seus gastos totais foram", style: TextStyle(color: const Color.fromARGB(255, 110, 109, 109), fontSize: 25),),
                  SizedBox(height: 8),
                  Text("R\$ 560,43", style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("R\$ 46,96 em média", style: TextStyle(color: const Color.fromARGB(255, 110, 109, 109), fontSize: 25),),
                  SizedBox(height: 8),
                  Text("O seu Insumo mais recorrente é", style: TextStyle(color: const Color.fromARGB(255, 110, 109, 109), fontSize: 25),),
                ],
              ),
            )
          ]
        ),
      ),



    );
  }
}