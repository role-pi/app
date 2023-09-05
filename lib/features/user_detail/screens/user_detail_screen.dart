import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/round_button.dart';

import '../../../shared/widgets/elastic_button.dart';

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
          child: Column(
        children: [
          ElasticButton(
              onTap: () {},
              child: ClipOval(
                child: Container(
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Icon(
                          CupertinoIcons.person_fill,
                          color: CupertinoColors.black,
                          size: 30.0,
                        )),
                  ),
                ),
              )),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 32, 32),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CupertinoTextFormFieldRow(
              placeholder: "Nome de Usuário",
              placeholderStyle: TextStyle(
                  color: CupertinoColors.systemGrey2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              style: TextStyle(
                color: CupertinoColors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 80,
            child: RoundButton(
              onPressed: () async {
                UserLoginProvider.shared.logout();
                Navigator.pushNamed(context, "/onboarding");
              },
              rectangleColor: CupertinoColors.white,
              textColor: CupertinoColors.systemRed,
              text: 'logout',
            ),
          ),
        ],
      )),
    );
  }
}
