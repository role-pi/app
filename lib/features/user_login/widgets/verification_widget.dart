import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/round_button.dart';

class VerificationWidget extends StatefulWidget {
  final Function(String)? onTap;

  VerificationWidget({this.onTap});

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  final _formKey = GlobalKey<FormState>();

  bool showBack = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserLoginProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "ótimo! ",
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: -1.6,
                height: 1.1,
              ),
              children: const <TextSpan>[
                TextSpan(
                    text:
                        "agora só precisamos do codigo de verificação que enviamos para você",
                    style: TextStyle(color: CupertinoColors.systemGrey)),
              ],
            ),
          ),
          SizedBox(height: 30),
          Material(
              color: CupertinoColors.black,
              child: Pinput(
                length: 6,
                controller: provider.codeController,
                pinAnimationType: PinAnimationType.none,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 70,
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(255, 255, 255, 0.05)),
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.length == 6 && int.tryParse(value) != null) {
                      return null;
                    }
                  }
                  return "O código é inválido.";
                },
                onChanged: (value) {
                  setState(() {
                    showBack = value.isEmpty;
                  });
                },
              )),
          SizedBox(height: 25),
          RoundButton(
            onPressed: () async {
              if (showBack) {
                provider.setState(LoginState.signIn);
              } else {
                widget.onTap?.call(provider.codeController.text);
              }
            },
            rectangleColor: CupertinoColors.darkBackgroundGray,
            textColor: CupertinoColors.white,
            text: showBack ? "voltar" : "verificar",
          ),
          SizedBox(height: 25),
          Consumer<UserLoginProvider>(
            builder: (context, value, child) {
              return AnimatedOpacity(
                opacity: value.failed ? 1 : 0,
                duration: Duration(milliseconds: 100),
                child: child,
              );
            },
            child: Text("opa! parece que o código informado é inválido.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CupertinoColors.systemRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: -1.1)),
          ),
          Spacer()
        ],
      ),
    );
  }
}
