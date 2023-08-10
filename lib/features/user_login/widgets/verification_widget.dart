import 'package:flutter/cupertino.dart';

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
          CupertinoTextFormFieldRow(
            placeholder: "Código",
            controller: _codeController,
            padding: EdgeInsets.all(10),
            style: TextStyle(color: CupertinoColors.white),
            keyboardType: TextInputType.number,
          ),
          CupertinoButton(
            onPressed: () async {
              onTap?.call(_codeController.text);
            },
            child: const Text('Verificar'),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
