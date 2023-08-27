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
  final _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showBack = true;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "ótimo! agora só precisamos do codigo de verificação que enviamos para você",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoColors.systemGrey2,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: -1.6,
              height: 1.1,
            ),
          ),
          SizedBox(height: 30),
          Material(
              color: CupertinoColors.black,
              child: Pinput(
                length: 6,
                controller: _codeController,
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
                loginProvider.setState(LoginState.signIn);
              } else {
                widget.onTap?.call(_codeController.text);
                if (_formKey.currentState!.validate()) {
                  widget.onTap?.call(_codeController.text);
                }
              }
            },
            rectangleColor: CupertinoColors.darkBackgroundGray,
            text: showBack ? 'voltar' : 'verificar',
          ),
          SizedBox(height: 25),
          Text(
            "reenviar código",
            style: TextStyle(
                color: Color.fromARGB(255, 72, 72, 72),
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: -1.2),
          ),
          Spacer()
        ],
      ),
    );
  }
}
