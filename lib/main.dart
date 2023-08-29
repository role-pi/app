import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:role/features/evento_detail/screens/evento_detail_screen.dart';
import 'package:role/features/evento_list/screens/evento_list_screen.dart';
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
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        title: 'rolê',
        debugShowCheckedModeBanner: false,
        initialRoute: "/onboarding",
        routes: {
          "/": (p0) => EventoListScreen(),
          "/onboarding": (p0) => UserLoginScreen()
        },
        onGenerateRoute: (settings) {
          late Widget page;

          if (settings.name == "/evento") {
            page = EventoDetailScreen(
              id: settings.arguments as int,
            );
          } else {
            page = EventoListScreen();
          }

          return CupertinoPageRoute(
            builder: (context) {
              return page;
            },
          );
        },
      ),
    );
  }
}
