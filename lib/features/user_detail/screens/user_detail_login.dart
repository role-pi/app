import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/default_user_icon.dart';
import 'package:role/shared/widgets/round_button.dart';

class UserDetailLogin extends StatefulWidget {
  final bool showing;
  final Function()? dismiss;

  UserDetailLogin({required this.showing, this.dismiss});

  @override
  _UserDetailLoginState createState() => _UserDetailLoginState();
}

class _UserDetailLoginState extends State<UserDetailLogin> {
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos horizontalmente
          children: [
            Text(
              "Tudo pronto!",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
                color: CupertinoColors.black.withOpacity(0.8),
              ),
            ),
            Text(
              "por último, gostaria de adicionar um nome e foto de perfil?",
              style: TextStyle(
                fontSize: 20,
                color: CupertinoColors.systemGrey2.withOpacity(0.8),
              ),
            ),
          ],
        ),
        DefaultUserIcon(),
          SizedBox(
            width: 200,
            height: 80,
            child: RoundButton(
              onPressed: () async {
              },
              rectangleColor: CupertinoColors.black,
              textColor: CupertinoColors.white,
              text: 'feito',
            ),
          ),
      ],
    );
  }
}
