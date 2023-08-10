import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/round_button.dart';

class VerificationWidget extends StatelessWidget {
  Function(String)? onTap;

  final _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  VerificationWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Spacer(),
          Text(
            "Otimo! agora só precisamos do codigo de verificação que enviamos no seu email",
            style: TextStyle(
              color: Color.fromARGB(255, 72, 72, 72),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          CupertinoTextFormFieldRow(
            placeholder: "Código",
            controller: _codeController,
            padding: EdgeInsets.all(10),
            style: TextStyle(color: CupertinoColors.white),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 25), 
          RoundButton(
            onPressed: () async {
              onTap?.call(_codeController.text);
            },
            text: 'verificar',
          ),
          Spacer(),
          Text(
            "reenviar codigo",
            style: TextStyle(
              color: Color.fromARGB(255, 72, 72, 72),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
