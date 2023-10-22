import 'package:flutter/cupertino.dart';
import 'package:role/features/evento_list/providers/evento_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:role/features/evento_list/widgets/evento_list.dart';
import 'package:role/features/new_evento/providers/new_evento_provider.dart';
import 'package:role/features/new_evento/screens/new_evento_screen.dart';

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
        ChangeNotifierProvider.value(value: EventoListProvider.shared),
        ChangeNotifierProvider.value(value: NewEventoProvider.shared)
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: CupertinoPageScaffold(
          child: Center(
            child: Stack(
              children: [
                EventoList(
                  onTap: () => {NewEventoProvider.shared.showing = true},
                ),
                NewEventoScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
