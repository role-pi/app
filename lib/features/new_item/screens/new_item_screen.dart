import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/providers/new_item_provider.dart';
import 'package:role/shared/widgets/custom_navigation_bar.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewItemScreen extends StatelessWidget {
  NewItemScreen(EventDetailProvider eventDetailProvider) {
    this.newItemProvider = NewItemProvider(eventDetailProvider);
  }

  late final NewItemProvider newItemProvider;

  void show(BuildContext context) {
    ModalPopup(
            context: context,
            title: "adicionar insumo",
            height: 400,
            child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newItemProvider,
      child: Column(children: [
        Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormItemTextField(
                      controller: newItemProvider.nameController,
                      title: "nome",
                    ),
                  ),
                  SizedBox(width: 12),
                  ElasticButton(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: CupertinoPicker(
                              itemExtent: 32,
                              onSelectedItemChanged: (int index) {},
                              children: <Widget>[
                                Text('🎟️'),
                                Text('🍺'),
                                Text('🎁'),
                                Text('🛒'),
                                Text('🛍️'),
                                Text('🚕'),
                                Text('🥩'),
                                // ...
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.tertiarySystemBackground
                            .resolveFrom(context),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.all(14.0),
                      child: Icon(
                        CupertinoIcons.smiley_fill,
                        color: CupertinoColors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newItemProvider.descricaoController,
                  title: "descrição"),
              SizedBox(height: 12),
              FormItemTextField(
                  controller: newItemProvider.valorController, title: "valor"),
              SizedBox(height: 12),
              RoundButton(
                  text: "adicionar",
                  onPressed: () {
                    newItemProvider.addItem(context);
                  })
            ],
          ),
        ))
      ]),
    );
  }
}
