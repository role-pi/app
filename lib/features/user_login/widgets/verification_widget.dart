import 'package:flutter/cupertino.dart';

class VerificationWidget extends StatelessWidget {
  Function()? onTap;

  final TextEditingController codeController;

  VerificationWidget({required this.codeController, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoTextFormFieldRow(
          placeholder: "Código",
          controller: codeController,
          padding: EdgeInsets.all(10),
          style: TextStyle(color: CupertinoColors.white),
          keyboardType: TextInputType.number,
        ),
        CupertinoButton(
          onPressed: () async {
            onTap?.call();
          },
          child: const Text('Verificar'),
        ),
      ],
    );
  }
}
