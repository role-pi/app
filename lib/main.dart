import 'package:flutter/cupertino.dart';
import 'package:role/screens/home_screen.dart';
import 'package:role/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'rolê',
        debugShowCheckedModeBanner: false,
        initialRoute: "/onboarding",
        routes: {
          "/": (p0) => HomeScreen(),
          "/onboarding": (p0) => OnboardingScreen()
        });
  }
}
