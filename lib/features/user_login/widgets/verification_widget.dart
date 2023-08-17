import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:role/shared/widgets/round_button.dart';

class VerificationWidget extends StatelessWidget {
  final Function(String)? onTap;

  final _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  VerificationWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            child: CupertinoTextFormFieldRow(
              placeholder: " ",
              controller: _codeController,
              padding: EdgeInsets.all(10),
              textAlign: TextAlign.center,
              cursorColor: CupertinoColors.white,
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.3,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 25),
          RoundButton(
            onPressed: () async {
              onTap?.call(_codeController.text);
            },
            rectangleColor: CupertinoColors.systemGrey6,
            text: 'verificar',
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
          Divider(),
          Spacer()
        ],
      ),
    );
  }
}
