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
    final provider = Provider.of<UserLoginProvider>(context);
    provider.tryAuthentication(() => Navigator.pushNamed(context, "/"));

    if (provider.state == LoginState.loggedOut) {
      return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoPageScaffold(
            child: Center(
                child: CupertinoActivityIndicator(
              radius: 20,
              color: CupertinoColors.label.resolveFrom(context),
            )),
            backgroundColor: CupertinoColors.systemBackground,
          ));
    } else {
      return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: CupertinoColors.white,
          ),
          child: WillPopScope(
            onWillPop: () async => false,
            child: CupertinoPageScaffold(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    top: provider.state == LoginState.signIn ? 450 : -350,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: LoginSlideComponent(
                                child: SignUpWidget(
                                  email: email,
                                  onTap: (email) async {
                                    this.email = email;
                                    await provider.trySignUp(email, () {});
                                  },
                                ),
                                showing: provider.state == LoginState.signIn),
                          ),
                          LoginSlideComponent(
                              child: VerificationWidget(
                                onTap: (code) async {
                                  await provider.verify(email, code, () {
                                    Navigator.pushNamed(context, "/");
                                  });
                                },
                              ),
                              showing: provider.state == LoginState.verify,
                              reversed: true)
                        ],
                      )),
                ],
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
          ));
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
