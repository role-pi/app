import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/event_edit/widgets/event_edit_guests.dart';
import 'package:role/features/event_edit/widgets/event_edit_info.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/round_button.dart';

class EventEditScreen extends StatelessWidget {
  EventEditScreen(EventDetailProvider eventDetailProvider) {
    this.eventEditProvider = EventEditProvider(eventDetailProvider);
  }

  late final EventEditProvider eventEditProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: eventEditProvider,
        child: CupertinoPageScaffold(
          child: SingleChildScrollView(
            child: Column(children: [
              Consumer<EventEditProvider>(builder: (context, provider, child) {
                return CustomNavigationBar(
                    trailingText: "salvar",
                    onPressedLeading: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTrailing: provider.changed
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              provider.put(context);
                            }
                          }
                        : null,
                    accentColor: provider.event.color1);
              }),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Column(
                    children: [
                      EventEditInfo(),
                      SizedBox(height: 12),
                      EventEditGuests(),
                      SizedBox(height: 12),
                      RoundButton(
                        onPressed: () => eventEditProvider.delete(context),
                        textColor: CupertinoColors.white,
                        rectangleColor: CupertinoColors.systemRed,
                        text: 'excluir evento',
                      ),
                      SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
