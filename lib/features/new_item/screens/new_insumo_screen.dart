import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/evento_detail_provider.dart';
import 'package:role/features/event_list/providers/evento_list_provider.dart';
import 'package:role/features/new_item/providers/new_insumo_provider.dart';
import 'package:role/models/event.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';

class NewInsumoScreen extends StatelessWidget {
  NewInsumoScreen(EventDetailProvider eventoDetailProvider) {
    this.newInsumoProvider = NewInsumoProvider(eventoDetailProvider);
  }

  late NewInsumoProvider newInsumoProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newInsumoProvider,
      child: CupertinoPageScaffold(
          child: Column(children: [
        Consumer<NewInsumoProvider>(builder: (context, provider, child) {
          return CustomNavigationBar(
              trailingText: "adicionar",
              onPressedLeading: () {
                Navigator.of(context).pop();
              },
              onPressedTrailing: provider.changed
                  ? () {
                      provider.addInsumo(context);
                    }
                  : null,
              accentColor: provider.evento.color1);
        }),
        Form(
            child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              FormItemTextField(
                  controller: newInsumoProvider.nameController, title: "nome"),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newInsumoProvider.descricaoController,
                  title: "descrição"),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newInsumoProvider.valorController,
                  title: "valor"),
            ],
          ),
        ))
      ])),
    );
  }
}
