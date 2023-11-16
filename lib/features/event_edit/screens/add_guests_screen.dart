import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/add_guests_provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
import 'package:role/features/event_edit/widgets/add_guest_search_result_item.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class AddGuestsScreen extends StatelessWidget {
  AddGuestsScreen(EventEditProvider eventEditProvider) {
    this.addGuestsPrvider = AddGuestsProvider(eventEditProvider);
  }

  late final AddGuestsProvider addGuestsPrvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addGuestsPrvider,
      child: CupertinoPageScaffold(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<AddGuestsProvider>(builder: (context, value, child) {
              return CustomNavigationBar(
                topPadding: 0,
                leadingIcon: null,
                leadingText: "adicionar participantes",
                trailingText: "feito",
                accentColor: addGuestsPrvider.event.color1,
                onPressedTrailing: value.changed
                    ? () {
                        value.put(context);
                      }
                    : null,
                textSize: 26,
              );
            }),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  FormItemTextField(
                    title: "busque por nome ou email",
                    controller: addGuestsPrvider.searchController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Consumer<AddGuestsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: value.users.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AddGuestSearchResultItem(index: index);
                      });
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
