import 'package:flutter/cupertino.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_list/widgets/evento_list.dart';
import 'package:role/features/new_event/providers/new_event_provider.dart';
import 'package:role/features/new_event/screens/new_event_screen.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  // bool showNewEvent = false;

  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeInOutQuad;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: EventListProvider.shared),
        ChangeNotifierProvider.value(value: NewEventProvider.shared)
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          child: Center(
            child: Stack(
              children: [
                EventList(
                  onTap: () => {NewEventProvider.shared.showing = true},
                ),
                NewEventScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
