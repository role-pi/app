import 'package:flutter/cupertino.dart';
import 'package:role/models/item.dart';
import 'package:role/shared/widgets/modal_popup.dart';

class ItemCategoryPickerModalPopup extends ModalPopup {
  ItemCategoryPickerModalPopup({
    required BuildContext context,
    required Function(ItemCategory) onSelected,
    required ItemCategory category,
  }) : super(
            context: context,
            title: "categoria",
            padding: EdgeInsets.only(top: 32),
            child: SizedBox(
              height: 200,
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: category.index),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  onSelected(ItemCategory.values[index]);
                },
                children:
                    List<Widget>.generate(ItemCategory.values.length, (index) {
                  ItemCategory category = ItemCategory.values[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(category.emoji + " " + category.name),
                  );
                }),
              ),
            ));
}
