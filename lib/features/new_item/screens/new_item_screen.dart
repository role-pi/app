import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/providers/new_item_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class NewItemScreen extends StatelessWidget {
  NewItemScreen(EventDetailProvider eventDetailProvider) {
    this.newItemProvider = NewItemProvider(eventDetailProvider);
  }

  late final NewItemProvider newItemProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newItemProvider,
      child: CupertinoPageScaffold(
          child: Column(children: [
        Consumer<NewItemProvider>(builder: (context, provider, child) {
          return CustomNavigationBar(
              trailingText: "adicionar",
              onPressedLeading: () {
                Navigator.of(context).pop();
              },
              onPressedTrailing: provider.changed
                  ? () {
                      provider.addItem(context);
                    }
                  : null,
              accentColor: provider.event.color1);
        }),
        Form(
            child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              FormItemTextField(
                  controller: newItemProvider.nameController, title: "nome"),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newItemProvider.descricaoController,
                  title: "descrição"),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newItemProvider.valorController, title: "valor"),
            ],
          ),
        ))
      ])),
    );
  }
}
