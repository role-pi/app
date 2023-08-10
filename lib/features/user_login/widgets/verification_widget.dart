import 'package:flutter/cupertino.dart';

class VerificationWidget extends StatelessWidget {
  final TextEditingController codeController;

  VerificationWidget({required this.codeController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        CupertinoTextFormFieldRow(
          placeholder: "Código",
          controller: codeController,
          padding: EdgeInsets.all(10),
          style: TextStyle(color: CupertinoColors.white),
          keyboardType: TextInputType.number,
        ),
        CupertinoButton(
          onPressed: () async {
            // Lógica para verificação
          },
          child: const Text('Verificar'),
        ),
      ],
    );
  }
}