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
              color: Color.fromARGB(255, 211, 209, 209),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 22), 
          Container(
          decoration: BoxDecoration(
           color: Color.fromARGB(255, 62, 62, 62), // Cor de fundo cinza escuro
           borderRadius: BorderRadius.circular(10), // Raio de borda para arredondamento
          ),
          padding: EdgeInsets.all(4),
         child: CupertinoTextFormFieldRow(
        placeholder: "Código",
         controller: _codeController,
         style: TextStyle(color: CupertinoColors.white),
          keyboardType: TextInputType.number,
         ),
          ),
          SizedBox(height: 25), 
          Container(
          decoration: BoxDecoration(
           color: Color.fromARGB(255, 169, 167, 167), // Cor de fundo cinza escuro
          borderRadius: BorderRadius.circular(10), // Raio de borda para arredondamento
          ),
          child: RoundButton(
         onPressed: () async {
          onTap?.call(_codeController.text);
         },
         text: 'verificar',
         textColor: const Color.fromARGB(255, 243, 243, 243),
          ),
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
