import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/screens/evento_list_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/screens/user_login_screen.dart';

void main() {
  runApp(RoleApp());
}

class RoleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLoginProvider.shared)
      ],
      child: CupertinoApp(
          title: 'rolê',
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: {
            "/": (p0) => EventoListScreen(),
            "/onboarding": (p0) => UserLoginScreen()
          }),
    );
  }
}
