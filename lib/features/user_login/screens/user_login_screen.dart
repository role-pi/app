import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/user_login/widgets/verification_widget.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/widgets/signup_widget.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  String? email;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<UserLoginProvider>(context);
    loginProvider.tryAuthentication(() => Navigator.pushNamed(context, "/"));

    if (loginProvider.state == LoginState.loggedOut) {
      return CupertinoPageScaffold(
        child: Center(
            child: CupertinoActivityIndicator(
          radius: 20,
          color: CupertinoColors.black,
        )),
        backgroundColor: CupertinoColors.white,
      );
    } else {
      return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.white,
        ),
        child: CupertinoPageScaffold(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                top: loginProvider.state == LoginState.signUp ? 450 : -350,
                left: 0,
                right: 0,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInOutExpo,
                child: Image.asset(
                  'assets/Background.png', // Caminho da sua imagem de fundo
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Stack(
                    children: [
                      LoginSlideComponent(
                          child: SignUpWidget(
                            email: email,
                            onTap: (email) async {
                              this.email = email;
                              await loginProvider.trySignUp(email, () {});
                              // loginProvider.setState(LoginState.verifying);
                            },
                          ),
                          showing: loginProvider.state == LoginState.signUp),
                      LoginSlideComponent(
                          child: VerificationWidget(
                            onTap: (code) async {
                              await loginProvider.verify(email, code, () {
                                Navigator.pushNamed(context, "/");
                              });
                            },
                          ),
                          showing: loginProvider.state != LoginState.signUp,
                          reversed: true)
                    ],
                  )),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
      );
    }
  }
}

class LoginSlideComponent extends StatelessWidget {
  const LoginSlideComponent({
    super.key,
    required this.child,
    required this.showing,
    this.reversed = false,
  });

  final Widget child;
  final bool showing;
  final bool reversed;

  Duration get duration => Duration(milliseconds: 750);
  Curve get curve => Curves.easeInOutExpo;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !showing,
      child: AnimatedSlide(
        offset: showing ? Offset.zero : Offset(0, reversed ? 0.1 : -0.1),
        duration: duration,
        curve: curve,
        child: AnimatedOpacity(
            opacity: showing ? 1 : 0,
            duration: duration,
            curve: showing ? curve : Curves.easeOutCirc,
            child: child),
      ),
    );
  }
}
