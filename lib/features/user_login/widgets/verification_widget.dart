import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/shared/widgets/big_form_text_field.dart';
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
          BigFormTextField(
            controller: _codeController,
            color: CupertinoColors.white,
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
                showBack = value?.isEmpty ?? true;
              });
            },
          ),
          SizedBox(height: 25),
          RoundButton(
            onPressed: () async {
              if (showBack) {
                loginProvider.setState(LoginState.signUp);
              } else {
                widget.onTap?.call(_codeController.text);
                if (_formKey.currentState!.validate()) {
                  widget.onTap?.call(_codeController.text);
                }
              }
            },
            rectangleColor: CupertinoColors.systemGrey6,
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
