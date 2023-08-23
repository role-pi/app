import 'package:flutter/cupertino.dart';
import 'package:role/shared/widgets/round_button.dart';

class SignUpWidget extends StatelessWidget {
  final Function(String)? onTap;

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SignUpWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Spacer(),
        Image.asset('assets/Invertida.png', height: 60),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "boas-vindas ao seu novo aplicativo de eventos",
                style: TextStyle(
                  color: CupertinoColors.systemGrey5,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: -1.7,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "para prosseguir, crie ou acesse sua conta",
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: -1.7,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 32, 32, 32), // Cor de fundo cinza escuro
            borderRadius:
                BorderRadius.circular(12), // Raio de borda para arredondamento
          ),
          padding: EdgeInsets.all(3),
          child: CupertinoTextFormFieldRow(
            placeholder: "digite seu e-mail",
            controller: _emailController,
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2),
            validator: (value) {
              print("teste");
              return validateEmail(value);
            },
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 12), // Adicione o espaçamento desejado acima
          child: RoundButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                onTap?.call(_emailController.text);
              }
            },
            textColor: CupertinoColors.black,
            rectangleColor: CupertinoColors.white,
            text: 'continuar',
          ),
        ),
        Spacer()
      ]), //
    ); //
  }

  String? validateEmail(String? value) {
    return null;
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

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Digite um email válido'
        : null;
  }
}
