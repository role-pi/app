import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_edit/providers/add_guests_provider.dart';
import 'package:role/features/event_edit/providers/event_edit_provider.dart';
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
          child: Column(
        children: [
          CustomNavigationBar(
            topPadding: 0,
            leadingIcon: null,
            leadingText: "adicionar participantes",
            trailingText: "feito",
            textSize: 26,
          ),
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
            child: SizedBox(
              height: 500,
              child: Consumer<AddGuestsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: value.users.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey6
                                    .resolveFrom(context),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: [
                                  Text(value.users[index].user.displayName),
                                  Spacer(),
                                  Icon(CupertinoIcons.checkmark_circle)
                                ],
                              )),
                        );
                      });
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
