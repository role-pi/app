import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/widgets/evento_list.dart';
import 'package:role/features/new_event/providers/new_evento_provider.dart';
import 'package:role/features/new_event/screens/emoji_evento_screen.dart';
import 'package:role/features/new_event/screens/new_evento_screen.dart';

class EventoListScreen extends StatefulWidget {
  @override
  _EventoListScreenState createState() => _EventoListScreenState();
}

class _EventoListScreenState extends State<EventoListScreen> {
  // bool showNewEvent = false;

  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventoListProvider.shared),
        ChangeNotifierProvider(create: (context) => NewEventoProvider.shared)
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          child: Center(
            child: Stack(
              children: [
                EventsList(
                  onTap: () => {NewEventoProvider.shared.setShowing(true)},
                ),
                NewEventoScreen(
                    // showing: showNewEvent,
                    // dismiss: () => {
                    //   setState(() {
                    //     showNewEvent = false;
                    //   })
                    // },
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
