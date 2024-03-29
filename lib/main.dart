import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/screens/event_detail_screen.dart';
import 'package:role/features/event_list/screens/event_list_screen.dart';
import 'package:role/features/item_detail/screens/item_detail_screen.dart';
import 'package:role/features/user_login/providers/user_login_provider.dart';
import 'package:role/features/user_login/screens/user_login_screen.dart';

void main() {
  initializeDateFormatting('pt');
  try {
    runApp(RoleApp());
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }
}

class RoleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserLoginProvider.shared)
      ],
      child: CupertinoApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en', 'US'), const Locale('pt', 'BR')],
        title: 'rolê',
        debugShowCheckedModeBanner: false,
        initialRoute: "/onboarding",
        routes: {
          "/": (p0) => EventListScreen(),
          "/onboarding": (p0) => UserLoginScreen(),
        },
        onGenerateRoute: (settings) {
          late Widget page;

          if (settings.name == "/event") {
            page = EventDetailScreen(
              settings.arguments as int,
            );
          } else {
            page = EventListScreen();
          }

          final uri = Uri.parse(settings.name!);
          if (uri.pathSegments.length == 4 &&
              uri.pathSegments[0] == 'event' &&
              uri.pathSegments[2] == 'item') {
            final itemId = int.tryParse(uri.pathSegments[3]) ?? 0;
            final eventId = int.tryParse(uri.pathSegments[1]) ?? 0;
            page = ItemDetailScreen(id: itemId, eventId);
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
