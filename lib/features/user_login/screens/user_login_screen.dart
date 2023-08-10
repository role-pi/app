import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/screens/evento_list_screen.dart';
import 'package:role/features/event_list/widgets/verification_widget.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginProvider>(context);
    loginProvider.tryAuthentication(() => Navigator.pushNamed(context, "/"));

    if (loginProvider.state == LoginState.signUp) {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.white,
        ),
        child: CupertinoPageScaffold(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Image.asset('assets/Invertida.png', height: 50),
                    Text(
                      "bem-vindo ao seu novo aplicativo de eventos",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
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
                        if (_formKey.currentState!.validate()) {
                          await loginProvider.trySignUp(
                              _emailController.text, () => {});
                          // Navegar para a tela de lista de eventos
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => EventoListScreen()),
                          );
                        }
                      },
                      child: const Text('Entrar'),
                    ),
                    SizedBox(height: 80),
                    VerificationWidget(
                        // onTap: () {
                        //   loginProvider.verify(
                        //       _emailController.text,
                        //       _codeController.text,
                        //       () => {Navigator.pushNamed(context, "/")});
                        // },
                        codeController: _codeController),
                    Spacer(),
                  ]),
            ),
          ),
          backgroundColor: CupertinoColors.black,
        ),
      );
    } else {
      return CupertinoPageScaffold(
        child: Center(
            child: CupertinoActivityIndicator(
          radius: 20,
          color: CupertinoColors.black,
        )),
        backgroundColor: CupertinoColors.white,
      );
    }
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
