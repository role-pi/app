import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/screens/evento_list_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/screens/user_login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLoginProvider())
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

class User extends ChangeNotifier {
  String? _token;
  String? _name;
  String? _email;
  String? _id;

  String? get token => _token;
  String? get name => _name;
  String? get email => _email;
  String? get id => _id;

  void setToken(String token) {
    _token = token;

    // store token on device

    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    notifyListeners();
  }
}
