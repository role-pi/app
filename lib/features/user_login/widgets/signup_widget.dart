import 'package:flutter/cupertino.dart';

class SignUpWidget extends StatelessWidget {
  Function(String)? onTap;

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          SizedBox(height: 50),
          CupertinoTextFormFieldRow(
            placeholder: "Email",
            controller: _emailController,
            padding: EdgeInsets.all(10),
            style: TextStyle(color: CupertinoColors.white),
            validator: (value) {
              return validateEmail(value);
            },
          ),
          CupertinoButton(
            onPressed: () async {
              onTap?.call(_emailController.text);
              // if (_formKey.currentState!.validate()) {
              //   await loginProvider.trySignUp(emailController.text, () => {});
              // }
            },
            child: const Text('Entrar'),
          ),
          Spacer(),
        ],
      ),
    );
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
