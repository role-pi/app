import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/round_button.dart';

class SignUpWidget extends StatelessWidget {
  Function(String)? onTap;

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showVerification = false;

  SignUpWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Image.asset('assets/Invertida.png', height: 50),
          SizedBox(height: 50),
          Text(
            "bem-vindo ao seu novo aplicativo de eventos",
            style: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 25), // Adicione o espaçamento desejado
          Text(
            "para prosseguir, crie sua conta!",
            style: TextStyle(
              color: const Color.fromARGB(255, 105, 105, 105),
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          SizedBox(height: 40),
          Container(
         decoration: BoxDecoration(
        color: Color.fromARGB(255, 62, 62, 62), // Cor de fundo cinza escuro
        borderRadius: BorderRadius.circular(10), // Raio de borda para arredondamento
        ),
         padding: EdgeInsets.all(3),
         child: CupertinoTextFormFieldRow(
        placeholder: "Digite seu Email",
         controller: _emailController,
         style: TextStyle(color: Color.fromARGB(255, 124, 121, 121)),
        validator: (value) {
        return validateEmail(value);
             },
           ),
          ),
          Padding(
          padding: EdgeInsets.only(top: 12), // Adicione o espaçamento desejado acima
          child: RoundButton(
          onPressed: () async {
          onTap?.call(_emailController.text);
         },
           textColor: CupertinoColors.black,
           rectangleColor: CupertinoColors.white,
            text: 'continuar',
           ),
         ),
      Spacer(),
      ], // 
       ), // 
      ); // 
      }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório'; // Retorna mensagem de erro se o campo estiver em branco
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Digite um email válido'
        : null;
  }
}
