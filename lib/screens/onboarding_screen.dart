import 'package:flutter/cupertino.dart';
import 'package:role/controllers/eventos_list_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () async {
            Navigator.pushNamed(context, "/");
          },
          child: const Text('Entrar'),
        ),
      ),
      backgroundColor: CupertinoColors.black,
    );
  }
}
