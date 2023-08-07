import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/widgets/evento_list.dart';
import 'package:role/features/new_event/screens/new_evento_screen.dart';

class EventoListScreen extends StatefulWidget {
  @override
  _EventoListScreenState createState() => _EventoListScreenState();
}

class _EventoListScreenState extends State<EventoListScreen> {
  bool showNewEvent = false;

  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventoListProvider.shared,
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          child: Center(
            child: Stack(
              children: [
                EventsList(
                  onTap: () => {
                    setState(() {
                      showNewEvent = !showNewEvent;
                    })
                  },
                ),
                NewEventoScreen(
                  showing: showNewEvent,
                  dismiss: () => {
                    setState(() {
                      showNewEvent = false;
                    })
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
