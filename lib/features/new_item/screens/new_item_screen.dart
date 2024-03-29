import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:role/features/event_detail/providers/event_detail_provider.dart';
import 'package:role/features/new_item/providers/new_item_provider.dart';
import 'package:role/shared/widgets/elastic_button.dart';
import 'package:role/shared/widgets/form/form_item_text_field.dart';
import 'package:role/shared/widgets/item_category_picker_modal.dart';
import 'package:role/shared/widgets/modal_popup.dart';
import 'package:role/shared/widgets/round_button.dart';

class NewItemScreen extends StatelessWidget {
  NewItemScreen(EventDetailProvider eventDetailProvider) {
    this.provider = NewItemProvider(eventDetailProvider);
  }

  late final NewItemProvider provider;

  void show(BuildContext context) {
    ModalPopup(
            context: context, title: "adicionar insumo", child: build(context))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Consumer<NewItemProvider>(
                    builder: (context, value, child) {
                      return FormItemTextField(
                        controller: provider.nameController,
                        title: "nome",
                        enabled: !value.loading,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                ElasticButton(
                  onPressed: () {
                    ItemCategoryPickerModalPopup(
                            context: context,
                            onSelected: (caegory) {
                              provider.category = caegory;
                            },
                            category: provider.item.category)
                        .show();
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
                          value.item.category.emoji,
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
                  controller: provider.valueController,
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
                          provider.addItem(context);
                        }
                      : null,
                  rectangleColor: provider.event.color2,
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
