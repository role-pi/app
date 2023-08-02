import 'package:flutter/cupertino.dart';
import 'package:role/controllers/eventos_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:role/screens/home_screen.dart';
import 'package:role/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventosListViewModel()),
      ],
      child: CupertinoApp(
          title: 'rolê',
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: {
            "/": (p0) => HomeScreen(),
            "/onboarding": (p0) => OnboardingScreen()
          }),
    );
  }
}
