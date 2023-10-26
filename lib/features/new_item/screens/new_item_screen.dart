import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/providers/new_item_provider.dart';
import 'package:role/models/item.dart';
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
            context: context, title: "adicionar insumo", child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newItemProvider,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Consumer<NewItemProvider>(
                    builder: (context, value, child) {
                      return FormItemTextField(
                        controller: newItemProvider.nameController,
                        title: "nome",
                        enabled: !value.loading,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                ElasticButton(
                  onTap: () {
                    ModalPopup(
                        context: context,
                        title: "categoria",
                        padding: EdgeInsets.only(top: 32),
                        child: SizedBox(
                          height: 200,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: newItemProvider.item.tipo.index),
                            itemExtent: 40,
                            onSelectedItemChanged: (int index) {
                              newItemProvider.category =
                                  ItemCategory.values[index];
                            },
                            children: List<Widget>.generate(
                                ItemCategory.values.length, (index) {
                              ItemCategory category =
                                  ItemCategory.values[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child:
                                    Text(category.emoji + " " + category.name),
                              );
                            }),
                          ),
                        )).show();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6.resolveFrom(context),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 11.0, horizontal: 13),
                    child: Consumer<NewItemProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.item.tipo.emoji,
                          style: TextStyle(fontSize: 24),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Consumer<NewItemProvider>(
              builder: (context, value, child) {
                return FormItemTextField(
                  controller: newItemProvider.valueController,
                  title: "valor",
                  enabled: !value.loading,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                );
              },
            ),
            SizedBox(height: 12),
            Consumer<NewItemProvider>(
              builder: (context, value, child) {
                return RoundButton(
                  text: "adicionar",
                  onPressed: value.changed
                      ? () {
                          newItemProvider.addItem(context);
                        }
                      : null,
                  rectangleColor: newItemProvider.event.color2,
                  textColor: CupertinoColors.white,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
